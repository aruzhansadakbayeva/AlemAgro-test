//
//  GetContractAnalysis.swift
//  AlemAgro
//
//  Created by Aruzhan  on 12.04.2023.
//

import SwiftUI

struct Contract: Codable, Identifiable {
    var id: Int
    var margin: String
    var sum: String
    var conditionPay: String
}

struct AvgContracts: Codable {
    var sum: String
    var margin: String
    var season: Int
}

struct Season3: Codable, Identifiable {
    var id: Int
    var season: String
    var contracts: [Contract]
    var avgContracts: AvgContracts
}

class CAViewModel: ObservableObject {
    @Published var response: [Season3] = []


    func fetchData() {
        let currentClientId = ClientIdManager.shared.getCurrentClientId() ?? 0
        let urlString = "http://10.200.100.17/api/client"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters =   [    "type": "client",
                                "action": "getContractAnalysis",
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
                let decodedResponse = try JSONDecoder().decode([Season3].self, from: data)
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
struct AvgContractsView: View {
    let avgContracts: AvgContracts
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Среднее значение")
                .fontWeight(.bold).foregroundColor(.green)
            Text("**Margin**: \(avgContracts.margin)")
            Text("**Sum**: \(avgContracts.sum)")
            Text("**Season**: \(String(avgContracts.season))")
        }
    }
}

struct CAView: View {
    @StateObject var viewModel = CAViewModel()
    
    var body: some View {
        VStack{
            List(viewModel.response) { season in
                NavigationLink(destination: ContractListView(contracts: season.contracts, avgContracts: season.avgContracts)) {
                    Text("\(season.season)")
                }
            }
            .navigationTitle("Сезоны")
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

struct ContractListView: View {
    let contracts: [Contract]
    let avgContracts: AvgContracts
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                AvgContractsView(avgContracts: avgContracts).padding(.leading, 37).padding(.top, 10)
            }
            List {
             
                ForEach(contracts) { contract in
                    VStack(alignment: .leading) {
                        Text("**Margin**: \(contract.margin)")
                        Text("**Sum**: \(contract.sum)")
                        Text("**Condition Pay**: \(contract.conditionPay)")
                    }
                }
            }
        }
     //   .navigationTitle("Анализ контрактов")
    }
}
