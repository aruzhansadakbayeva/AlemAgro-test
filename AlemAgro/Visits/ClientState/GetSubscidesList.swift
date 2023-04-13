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

struct Category2: Identifiable, Codable {
    let id = UUID()
    let category: String
    let contracts: [SubscidesList]
}

struct Season2: Identifiable, Codable {
    let id = UUID()
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
    @State private var selectedCategory: UUID? = nil
    @Environment(\.colorScheme) var colorScheme

    var colorPrimary: Color {
        return colorScheme == .dark ? .white : .black
    }
    var body: some View {
  
            VStack {
                List {
                    ForEach(viewModel.response, id: \.id) { season in
                        Section(header: Text(season.season)) {
                            ForEach(season.categories, id: \.id) { category in
                                NavigationLink(destination: CategoryView2(category: category, selectedCategory: $selectedCategory)) {
                                    Text(category.category)
                                        .font(.headline)
                                     .foregroundColor(colorPrimary)
                                }
                                .disabled(selectedCategory == category.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Список субсидий")
            .onAppear {
                // Fetch data when the view appears
                viewModel.fetchData()
            }
        
    }
}

struct CategoryView2: View {
    let category: Category2
    @Binding var selectedCategory: UUID?
    
    var body: some View {
        VStack {
            List{
                
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
                    .padding()
                }
            }
        }
        .navigationTitle(category.category)
        .onAppear {
            selectedCategory = category.id
        }
    }
}


