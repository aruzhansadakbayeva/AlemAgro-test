//
//  GetCropRotation.swift
//  AlemAgro
//
//  Created by Aruzhan  on 11.04.2023.
//

import SwiftUI


struct CropData: Identifiable, Decodable {
    let id: Int?
    let season: String?
    let cultures: [Culture]?
    
    struct Culture: Identifiable, Decodable {
        let id: String?
        let culture: String?
        let area: String?
    }
}

class CropRotationViewModel: ObservableObject {
    @Published var response: [CropData] = []


    func fetchData() {
        let currentClientId = ClientIdManager.shared.getCurrentClientId() ?? 0
        let urlString = "http://10.200.100.17/api/client"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters =   [    "type": "client",
                                "action": "getCropRotation",
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
                let decodedResponse = try JSONDecoder().decode([CropData].self, from: data)
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
struct SeasonCropView: View {
    @StateObject var viewModel = CropRotationViewModel()
    
    var body: some View {
        VStack{
            List(viewModel.response) { cropData in
                NavigationLink(destination: CultureListView(cultures: cropData.cultures ?? [])) {
                    VStack(alignment: .leading) {
                        Text("Сезон \(cropData.season ?? "")")
        
                   
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationTitle("Севооборот клиента")
        }
    }
}

struct CultureListView: View {
    let cultures: [CropData.Culture]
    
    var body: some View {
        List(cultures) { culture in
            VStack(alignment: .leading) {
                Text("**Культура**: \(culture.culture ?? "")")
               
                Text("**Площадь**: \(culture.area ?? "")")
               
            }
        }
        .navigationTitle("Культуры")
    }
}
