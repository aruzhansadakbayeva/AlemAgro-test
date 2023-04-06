//
//  GetSubscidesList.swift
//  AlemAgro
//
//  Created by Aruzhan  on 06.04.2023.
//

import SwiftUI

struct SubscidesList: Decodable, Hashable {
    let season: Int?
    let providerName: String?
    let providerIin: Int?
    let productName: String?
    let sumSubcides: String?
    let productVolume: Double?
    let productUnit: String?
    let usageArea: String?

}
class SubscidesViewModel: ObservableObject {
    @Published var response: [SubscidesList] = []


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
                let decodedResponse = try JSONDecoder().decode([SubscidesList].self, from: data)
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
                Text("Список субсидий")
                    .font(.title2)
                    .padding()
                
                List(viewModel.response, id: \.self) { subscide in
                    VStack(alignment: .leading) {
                        Text("**Season**: \(subscide.season ?? 0)")
                        Text("**Provider Name**: \(subscide.providerName ?? "")")
                        Text("**Provider IIN**: \(subscide.providerIin ?? 0)")
                        Text("**Product Name**: \(subscide.productName ?? "")")
                        Text("**Sum Subcides**: \(subscide.sumSubcides ?? "")")
                        Text("**Product Volume**: \(subscide.productVolume ?? 0)")
                        Text("**Product Unit**: \(subscide.productUnit ?? "")")
                        Text("**Usage Area**: \(subscide.usageArea ?? "")")
                    }
                }.padding()
            }
            .onAppear {
                viewModel.fetchData() // Вызываем метод fetchData() для получения данных
            }
        
    }
}
