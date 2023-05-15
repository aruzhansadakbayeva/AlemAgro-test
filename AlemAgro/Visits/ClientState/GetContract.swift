//
//  GetContract.swift
//  AlemAgro
//
//  Created by Aruzhan  on 06.04.2023.
//

import SwiftUI

struct Product: Identifiable, Codable {
    let id = UUID()
    let productName: String?
    let avgPrice: String?
    let count: String?
}

struct Category:Identifiable, Codable{
    let id = UUID()
    let category: String?
    let contracts: [Product]?
}

struct Season: Identifiable, Codable {
    let id = UUID()
    let season: String?
    let categories: [Category]?
}
class ContractViewModel: ObservableObject {
    @Published var response: [Season] = []


    func fetchData() {
        let currentClientId = ClientIdManager.shared.getCurrentClientId() ?? 0
        let urlString = "http://localhost:5001/api/meetings"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters =   [  "type": "client",
        "action": "getContract",
        "clientId": currentClientId] as [String : Any]
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
    @Environment(\.colorScheme) var colorScheme

    var colorPrimary: Color {
        return colorScheme == .dark ? .white : .black
    }
    var body: some View {
  
            VStack {
                List {
                    ForEach(contractViewModel.response, id: \.id) { season in
                        Section(header: Text(season.season ?? "")) {
                            ForEach(season.categories ?? [], id: \.id) { category in
                                NavigationLink(destination: CategoryView(category: category, selectedCategory: $selectedCategory)) {
                                    Text(category.category ?? "")
                                        .font(.headline)
                                        .foregroundColor(colorPrimary)
                                }
                                .disabled(selectedCategory == category.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Контракты клиента")
            .onAppear {
                // Fetch data when the view appears
                contractViewModel.fetchData()
            }
        
    }
}

struct CategoryView: View {
    let category: Category
    @Binding var selectedCategory: UUID?
    
    var body: some View {
        VStack {
            List{
                
                ForEach(category.contracts ?? []) { product in
                    VStack(alignment: .leading) {
                        Text("**Продукт**: \(product.productName ?? "")")
                       
                        Text("**Количество продуктов**: \(product.count ?? "")")
                        Text("**Средняя цена**: \(product.avgPrice ?? "")")
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(category.category ?? "")
        .onAppear {
            selectedCategory = category.id
        }
    }
}


   // Usage:
   // Create an instance of the ContractView and display it in your SwiftUI hierarchy
   // For example, you can add it to a NavigationView or present it in a sheet, etc.




