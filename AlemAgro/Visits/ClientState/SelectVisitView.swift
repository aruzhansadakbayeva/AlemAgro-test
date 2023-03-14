//
//  Test3.swift
//  AlemAgro
//
//  Created by Aruzhan  on 14.03.2023.
//


import SwiftUI

struct PostmanResponse: Decodable{
    var id: Int
    var name: String

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

    var body: some View {
           List(viewModel.response, id: \.id) { item in
               VStack(alignment: .leading) {
                  
                   Text("\(item.name)")
               }
           }
           .onAppear {
               viewModel.fetchData()
           }
       }
}
