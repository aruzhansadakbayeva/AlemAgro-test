//
//  ClientState.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import SwiftUI
import Combine

struct ClientStView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State var filteredData: [CombinedData] = []
    let data: CombinedData
    @State private var response: String = ""
    var body: some View {
        NavigationView{
        
                VStack(alignment: .leading){
                    Text("**Компания**: \(data.company)")
                    Text("**Дата**: \((data.time).formatted(.dateTime.day().month()))")
                    Text("**Район**: \(data.district)")
                    Text("**Потенциал**: \(data.potential) тг")
                    Text("**Проникновение АА**: \(data.pa) %")
                    Text("**Количество Визитов**: \(data.visitsQty)")
                    Text("**Cумма Закл Договоров**: \((data.potential)/100*10) 10% от потенциала")
                    
                    VStack {
                               Text(response)
                                   .padding()

                               Button(action: {
                                   makeRequest()
                               }, label: {
                                   Text("Start")
                               })
                           }
                    
                }
            
                
                .frame(maxWidth: .infinity, alignment: .leading).padding().background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous)).padding(.horizontal, 4)
            
        }
        
    }
    
    func makeRequest() {
        let newStatus = Status(isFlagged: true, timestamp: Date())
        guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts") else {
            return
        }

        let data = ["isTrue": true] // boolean data to send in the request body
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response")
                return
            }

            guard let data = data else {
                print("Error: missing response data")
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.response = responseString
                }
            }
        }

        task.resume()
    }
}
    
struct Status: Codable {
    var isFlagged: Bool
    var timestamp: Date
}
