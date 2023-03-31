//
//  WholeModel.swift
//  AlemAgro
//
//  Created by Aruzhan  on 20.03.2023.
//

import Foundation
import SwiftUI

struct ClientObject: Decodable {
    let clientId: Int
    let clientName: String
    let clientCategory: String
    let address: String
    let contactInf: [ContactInfo]
    let clientIin: Int
    let managerId: Int?
    let managerName: String?
    let startVisit: String?
    let finishVisit: String?
    let statusVisit: Bool
    let visitTypeId: Int
    let visitTypeName: String?
    let meetingTypeId: Int
    let meetingTypeName: String
    let meetingCoordinate: String
    let plotId: Int
    let plotName: String?
    let summContract: String
    let summCurrentContractSeason: String
    let allContractsAa: [AllContractsAa]
    let potentialClientPercent: String
    let subscidesSum: String
    let subscidesList: [SubscidesList]
}

struct ContactInfo: Identifiable, Decodable {
    let id: String
    let position: String
    let name: String
    let phNumber: String
    let email: String?
}

struct AllContractsAa: Decodable{
    let productName: String
    let productCount: String
    let avgPrice: String
}

struct SubscidesList: Decodable {
    let season: Int
    let providerName: String
    let providerIin: Int
    let productName: String
    let sumSubcides: String
    let productVolume: Double
    let productUnit: String
    let usageArea: String
}
struct ClientData: Decodable {
    let clientObj: [ClientObject]
}




class DetailClientViewModel: ObservableObject {
    @Published var response: [ClientObject] = []

    
    
    func fetchData() {
       
        let currentVisitId = VisitIdManager.shared.getCurrentVisitId() ?? 0
print("Current visit id: \(currentVisitId)")
  

        
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        let parameters = ["type": "plannedMeetingMob","action": "getDetailMeeting", "visitId": currentVisitId] as [String : Any]
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
                let decodedResponse = try JSONDecoder().decode(ClientData.self, from: data)
                DispatchQueue.main.async {
                    self.response = decodedResponse.clientObj
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch: \(context)")
            } catch let error {
                print("Error decoding response: \(error)")
            }
            
          //  print(String(data: data, encoding: .utf8)!)
        }.resume()

    }
}


struct ClientObjectView: View {
    @StateObject var viewModel = DetailClientViewModel()

    var body: some View {
        List(viewModel.response, id: \.clientId) { clientObject in
            VStack(alignment: .leading) {
                Text("Client ID: \(clientObject.clientId)")
                Text("Client Name: \(clientObject.clientName)")
                Text("Client Category: \(clientObject.clientCategory)")
                Text("Address: \(clientObject.address)")
                ForEach(clientObject.contactInf) { contact in
                    Text("Contact Info:")
                    Text("ID: \(contact.id)")
                    Text("Position: \(contact.position)")
                    Text("Name: \(contact.name)")
                    Text("Phone Number: \(contact.phNumber)")
                    if let email = contact.email {
                        Text("Email: \(email)")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}
