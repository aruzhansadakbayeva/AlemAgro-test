//
//  GetSubscidesList.swift
//  AlemAgro
//
//  Created by Aruzhan  on 06.04.2023.
//

import SwiftUI

struct SubscidesList: Identifiable, Codable {
    let id = UUID()
    let clientName: String?
    let region: String?
    let usageArea: String?
    let providerName: String?
    let productName: String?
    let productPrice: String?
    let sum: String?
    let count: String?
    let unit: String?
  

}

struct Category2: Codable {
    let category: String
    let contracts: [SubscidesList]
}

struct Season2: Codable {
    let season: String
    let categories: [Category2]
}
class SubscidesViewModel: ObservableObject {
    @Published var response: [Season2] = []


    func fetchData() {
        let currentClientId = ClientIdManager.shared.getCurrentClientId() ?? 0
        let urlString = "http://10.200.100.17/api/client"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters =   [  "type": "client",
        "action": "getSubscidesList",
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
                let decodedResponse = try JSONDecoder().decode([Season2].self, from: data)
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

struct GetSubscidesList: View {
    @ObservedObject var viewModel = SubscidesViewModel() // Создаем экземпляр SubscidesViewModel
    

    var body: some View {
        VStack {
            // Display the received response on the screen
            List {
                ForEach(viewModel.response, id: \.season) { season in
                    Section(header: Text(season.season)) {
                        ForEach(season.categories, id: \.category) { category in
                            VStack(alignment: .leading) {
                                Text(category.category)
                                    .font(.headline)
                                    ForEach(category.contracts) { product in
                                        VStack(alignment: .leading) {
                                            Text("**Клиент**: \(product.clientName ?? "")")
                                            Text("**Регион**: \(product.region ?? "")")
                                            Text("**Usage Area**: \(product.usageArea ?? "")")
                                            Text("**Имя провайдера**: \(product.providerName ?? "")")
                                         
                                            Text("**Продукт**: \(product.productName ?? "")")
                                            Text("**Цена продукта**: \(product.productPrice ?? "")")
                                            Text("**Сумма**: \(product.sum ?? "")")
                                            Text("**Кол-во**: \(product.count ?? "")")
                                            Text("**Единица**: \(product.unit ?? "")")
                                 
                                        }
                                    }.padding()
                            }
                        }
                    }
                }
            }
        }
             .onAppear {
                viewModel.fetchData() // Вызываем метод fetchData() для получения данных
            }
        
    }
}
