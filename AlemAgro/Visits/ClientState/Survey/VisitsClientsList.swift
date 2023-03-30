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
    let statusVisit: Bool
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
    @Published var currentUserId: Int = 0

 //   let currentUserId = UserIdManager.shared.getCurrentUserId() ?? 0

    func fetchData() {
       
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "plannedMeetingMob","action": "getMeetings", "userId": currentUserId] as [String : Any]
        print(parameters)
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
        //    print(String(data: data, encoding: .utf8)!)
        }.resume()
      
    }
      
}


/*     NavigationLink(destination: WebView(url: {
    var components = URLComponents(string: "http://my.alemagro.com/meeting-details-mobile")!
    components.queryItems = [
        URLQueryItem(name: "meetingId", value: "\(client.visitId)"),
        URLQueryItem(name: "userId", value: "\(client.clientId)")
    ]
    return components.url!
}()) ) */
struct VisitListView: View {
    @State private var selectedDate = Date()
    @StateObject var viewModel = VisitViewModel()
    @State private var title = "Встречи"
    @EnvironmentObject var appState: AppState
    var sortedVisits: [Visit] {
        viewModel.response.sorted(by: { $0.dateToVisit > $1.dateToVisit })
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(sortedVisits) { visit in
                    if !visit.clients.isEmpty {
                        ForEach(visit.clients, id: \.clientId) { client in
                            NavigationLink(destination: ClientDetailView(client: client)) {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(client.clientName)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Text(visit.statusVisit)
                                            .font(.subheadline)
                                          //  .foregroundColor(.black)
                                    }
                                    Text(client.dateVisit)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(title)
        .onAppear {
                   if let userId = appState.currentUser?.id {
                       viewModel.currentUserId = userId
                       viewModel.fetchData()
                   }
               }
    }
}


struct ClientDetailView: View {
    let client: Clientt
    @State private var visitId: Int = 0 // Add a state variable to hold the visitId
    @State private var statusVisit: Bool = false // Add a state variable to hold the statusVisit value

    @State var buttonPressed = false
    @State var isFinished = false

    var body: some View {
   
        List{
            VStack(alignment: .leading){
                Text("\(client.clientName)").fontWeight(.bold)
                Text("**Дата встречи**: \(client.dateVisit)")
                Text("**ИИН**: \(String(client.clientIin))")
                Text("**VisitId**: \(String(client.visitId))")
                Text("**Цель визита**: \(client.meetingTypeName ?? "")")
                
            }
        

               
            }.navigationBarItems(
                                    trailing:
                                        Button(action: {
                                            statusVisit = true // Set the statusVisit to true when the button is tapped
                                            sendVisitIdToAPI() // Call the function to send the visitId to the API
                                            self.buttonPressed.toggle()
                                        }) {
                                            if !buttonPressed {
                                                HStack {
                                                    Image(systemName: "play.circle").padding(5)
                                                    Text("Начать визит").font(.subheadline).fontWeight(.bold).padding(5)
                                                }
                                                .foregroundColor(.white)
                                           
                                                .background(Color.blue)
                                           
                                                .cornerRadius(7)
                                            }
                                            if buttonPressed {
                                                Button(action: {
                                                    self.isFinished.toggle()
                                                    statusVisit = false
                                                    sendVisitIdToAPI2()
                                                    
                                                }) {
                                                    if !isFinished {
                                                        HStack {
                                                            Image(systemName: "stop.circle").padding(5)
                                                            Text("Завершить визит").fontWeight(.bold).font(.subheadline).padding(5)
                                                        }
                                                        .foregroundColor(.white)
                                                  
                                                        .background(Color.red)
                                                        .cornerRadius(7)
                                                    }
                                                }
                                                if isFinished{
                                                    
                                                    NavigationLink(
                                                        destination: SelectVisitView(),
                                                        label: {
                                                            Text("Продолжить").fontWeight(.bold).foregroundColor(Color.white)
                                                                .foregroundColor(.white)
                                                                .font(.subheadline).padding(5)
                                                                .background(Color.green)
                                                                .cornerRadius(7)
                                                        })
                                                    
                                                }
                                            }
                                        }
                                ).onAppear {
                                    VisitIdManager.shared.setCurrentVisitId(id: client.visitId)
                                }

   
    }
 
    func sendVisitIdToAPI() {
    
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        let defaults = UserDefaults.standard
        defaults.set("VisitId", forKey: "visitId")
        let parameters = ["type": "plannedMeetingMob", "action": "setStartVisit", "visitId": client.visitId] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
      print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
    
    init(client: Clientt) {
        self.client = client
        self.visitId = client.visitId // Assign the visitId from the client to the state variable
    }
    
    func sendVisitIdToAPI2() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        let parameters = ["type": "plannedMeetingMob", "action": "setFinishVisit", "visitId": client.visitId] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
    

}


class VisitIdManager {
    static let shared = VisitIdManager()
    
    private var currentVisitId: Int? = nil
    
    func setCurrentVisitId(id: Int) {
        currentVisitId = id
    }
    
    func getCurrentVisitId() -> Int? {
        return currentVisitId
    }
}

class UserIdManager {
    static let shared = UserIdManager()
    
    private var currentUserId: Int? = nil
    
    func setCurrentUserId(id: Int) {
        currentUserId = id
    }
    
    func getCurrentUserId() -> Int? {
        return currentUserId
    }
}
