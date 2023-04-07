//
//  GetContract.swift
//  AlemAgro
//
//  Created by Aruzhan  on 06.04.2023.
//

import SwiftUI

struct Contract: Decodable, Hashable {
    let productName: String?
    let productCount: String?
    let avgPrice: String?

}
class ContractViewModel: ObservableObject {
    @Published var response: [Contract] = []


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
                let decodedResponse = try JSONDecoder().decode([Contract].self, from: data)
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
    @ObservedObject var contractViewModel = ContractViewModel()

       var body: some View {
           VStack {
               Text("Контракты")
                   .font(.title2)
                   .padding()
               
               List(contractViewModel.response, id: \.self) { contract in
                   VStack(alignment: .leading) {
                       Text("**Продукт**: \(contract.productName ?? "")")
                       Text("**Количество**: \(contract.productCount ?? "")")
                       Text("**Средняя цена**: \(contract.avgPrice ?? "")")
                   }
               }
               .padding()
           }
           .onAppear {
               // Call the fetchData() function when the view appears
               contractViewModel.fetchData()
           }
       }
   }

   // Usage:
   // Create an instance of the ContractView and display it in your SwiftUI hierarchy
   // For example, you can add it to a NavigationView or present it in a sheet, etc.




