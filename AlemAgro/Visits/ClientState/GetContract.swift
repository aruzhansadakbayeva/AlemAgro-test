//
//  GetContract.swift
//  AlemAgro
//
//  Created by Aruzhan  on 06.04.2023.
//

import SwiftUI

struct Product: Identifiable, Codable {
    let id = UUID()
    let productName: String
    let avgPrice: String
    let count: String
}

struct Category:Identifiable, Codable{
    let id = UUID()
    let category: String
    let contracts: [Product]
}

struct Season: Identifiable, Codable {
    let id = UUID()
    let season: String
    let categories: [Category]
}
class ContractViewModel: ObservableObject {
    @Published var response: [Season] = []


    func fetchData() {
        let currentClientId = ClientIdManager.shared.getCurrentClientId() ?? 0
        let urlString = "http://10.200.100.17/api/client"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters =   [  "type": "client",
        "action": "getContract",
        "clientId": 2191] as [String : Any]
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
                let decodedResponse = try JSONDecoder().decode([Season].self, from: data)
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
struct GetContract: View {
    @StateObject var contractViewModel = ContractViewModel()
    @State private var selectedCategory: UUID? = nil
    
    var body: some View {
        VStack {
            // Display the received response on the screen
            List {
                ForEach(contractViewModel.response, id: \.id) { season in
                    Section(header: Text(season.season)) {
                        ForEach(season.categories, id: \.id) { category in
                          
                                Button(action: {
                                    // Toggle the selected category
                                    if selectedCategory == category.id {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category.id
                                    }
                                }) {
                                    Text(category.category)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                                .disabled(selectedCategory == category.id)

                                if selectedCategory == category.id {
                                    // Add a button to hide the selected category
                                    Button(action: {
                                        selectedCategory = nil
                                    }) {
                                        Text("Скрыть категорию")
                                    }
                                    ForEach(category.contracts) { product in
                                        VStack(alignment: .leading) {
                                            Text("**Продукт**: \(product.productName)")
                                            Text("**Средняя цена**: \(product.avgPrice)")
                                            Text("**Кол-во**: \(product.count)")
                                        }
                                      
                                    }.padding()
                                }
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            // Fetch data when the view appears
            contractViewModel.fetchData()
        }
    }
}


   // Usage:
   // Create an instance of the ContractView and display it in your SwiftUI hierarchy
   // For example, you can add it to a NavigationView or present it in a sheet, etc.




