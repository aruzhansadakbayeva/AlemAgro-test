//
//  Test3.swift
//  AlemAgro
//
//  Created by Aruzhan  on 14.03.2023.
//


import SwiftUI

struct PostmanResponse: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: PostmanResponse, rhs: PostmanResponse) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


class PostmanViewModel: ObservableObject {
    @Published var response: [PostmanResponse] = []
    
    func fetchData() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "meetingSurvey", "action": "getHandBookWorkDone"]
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
                let decodedResponse = try JSONDecoder().decode([PostmanResponse].self, from: data)
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

struct SelectVisitView: View {
    @StateObject var viewModel = PostmanViewModel()
    @State var selectedItems = Set<PostmanResponse>()

    var body: some View {
        List(viewModel.response, id: \.id, selection: $selectedItems) { item in
            HStack {
                Text("\(item.name)")
                Spacer()
                if selectedItems.contains(item) {
                    if (item.name == "Осмотр поля") {
                        NavigationLink(destination: FieldView()) {
                            EmptyView()
                        }
                    } else if (item.name == "Заключение Договора") {
                        NavigationLink(destination: ContentView()) {
                            EmptyView()
                        }
                    }
                    Image(systemName:"checkmark.square.fill")
                        .foregroundColor(.blue)
                }
                if !selectedItems.contains(item) {
                    Image(systemName:"square")
                        .foregroundColor(.blue)
                }
            }
            .onTapGesture {
                if selectedItems.contains(item) {
                    selectedItems.remove(item)
                } else {
                    selectedItems.insert(item)
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

