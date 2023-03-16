//
//  VisitsClientsList.swift
//  AlemAgro
//
//  Created by Aruzhan  on 14.03.2023.
//
import SwiftUI

struct Visit: Identifiable, Decodable{
    let id: Int
    let dateToVisit: String
    let statusVisit: String
    let clients: [Clientt]
    
}


struct Clientt: Decodable  {

    let visitId: Int
    let clientId: Int
    let clientName: String
    let dateVisit: String
    let clientIin: Int
    let clientAddress: String?
    let visitTypeName: String?
    let visitTypeId: Int
    let meetingTypeId: Int
    let meetingTime: String?
    let meetingTypeName: String?
    let plotId: Int
}



class VisitViewModel: ObservableObject {
    @Published var response: [Visit] = []
    
    func fetchData() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "plannedMeetingMob","action": "getMeetings", "userId": 1174] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
                    
            do {
                let decodedResponse = try JSONDecoder().decode([Visit].self, from: data)
                DispatchQueue.main.async {
                    self.response = decodedResponse
                }
            } catch let error {
                print("Error decoding response: \(error)")
            }
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}

struct VisitListView: View {
    @State private var selectedDate = Date()
    @StateObject var viewModel = VisitViewModel()
    @State private var filteredVisits: [Visit] = []

        var body: some View {
            NavigationView {
                VStack {
                    List(viewModel.response, id: \.id) { visit in
                        VStack(alignment: .leading) {
                            Text("Дата:")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("\(visit.dateToVisit)")
                                .font(.headline)
                                .padding(.bottom)
                            Text("Статус:")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("\(visit.statusVisit)")
                                .font(.headline)
                                .padding(.bottom)
                        }
                        
                        // Show NavigationLink for each client
                        ForEach(visit.clients, id: \.clientId) { client in
                            if !visit.clients.isEmpty {
                                NavigationLink(destination: ClientsList(client: client)){
                                    VStack(alignment: .leading) {
                                        Text("Клиент:")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("\(client.clientName)")
                                            .font(.headline)
                                            .padding(.bottom)
                                        Text("ИИН:")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("\(client.clientIin)")
                                            .font(.headline)
                                            .padding(.bottom)
                                        Text("Цель визита:")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        Text("\(client.meetingTypeName ?? "")")
                                            .font(.headline)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .navigationTitle("Planned Visits")
                .navigationBarTitleDisplayMode(.large)

            .onAppear {
                viewModel.fetchData()
            }
        }
    }

/*
    private func filterVisits() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDateFormatter = DateFormatter()
        selectedDateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDateStr = selectedDateFormatter.string(from: selectedDate)
        let selectedDate = selectedDateFormatter.date(from: selectedDateStr)!
        self.filteredVisits = viewModel.response.filter {
            if let date = dateFormatter.date(from: $0.dateToVisit) {
                return Calendar.current.isDate(date, inSameDayAs: selectedDate)
            } else {
                return false
            }
        }
        print(filteredVisits)
    }
    */
}
