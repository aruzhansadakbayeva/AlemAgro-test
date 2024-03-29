//
//  WholeModel.swift
//  AlemAgro
//
//  Created by Aruzhan  on 20.03.2023.
//

import Foundation
import SwiftUI

struct ClientObject: Decodable {
    let clientId: Int?
    let clientName: String?
    let clientCategory: String?
    let address: String?
    let contactInf: [ContactInf]?
    let clientIin: Int?
    let managerId: Int?
    let managerName: String?
    let startVisit: String?
    let finishVisit: String?
    let statusVisit: Bool?
    let visitTypeId: Int?
    let visitTypeName: String?
    let meetingTypeId: Int?
    let meetingTypeName: String?
    let meetingCoordinate: String?
    let plotId: Int?
    let plotName: String?
    let summContract: String?
    let summCurrentContractSeason: String?
    let checkContracts: Bool?
    let potentialClientPercent: String?
    let subscidesSum: String?
    let checkSubscides: Bool
    let duration: String?
    let distance: String?
}

struct ContactInf: Identifiable, Decodable {
    let id: String?
    let position: String?
    let name: String?
    let phNumber: String?
    let email: String?
}

struct ClientData: Decodable {
    let data: ClientObject?
}




class DetailClientViewModel: ObservableObject {
    @Published var response: ClientObject?

    
    
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
                    self.response = decodedResponse.data
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
    @StateObject var fileListModel = FileListModel()
    @State private var showDocumentPicker = false
    @State private var showImagePicker = false
    let client: Clientt
    var body: some View {
       
        VStack(spacing: 20){
                  
            ForEach(fileListModel.files) { fileItem in
                VStack(alignment: .leading) {
                   /* Text(fileItem.name)
                    Spacer()
                    */
                    Text("\(fileItem.fileURL.lastPathComponent)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            .onDelete(perform: fileListModel.removeFile)
            
                    HStack{
                        
                     
                        Button(action: {
                            showDocumentPicker = true
                        }) {
                            Label("Выбрать файл", systemImage: "doc")
                        }  .sheet(isPresented: $showDocumentPicker) {
                            DocumentPicker(fileURLs: $fileListModel.files)
                        }
                        Spacer()
                        /*
                        ForEach(fileListModel.files) { fileItem in
                            HStack {
                                /* Text(fileItem.name)
                                 Spacer()
                                 */
                                Text("\(fileItem.fileURL.lastPathComponent)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                         
                        
                        .onDelete(perform: fileListModel.removeFile)
                         */
                        
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Label("Выбрать фото/видео", systemImage: "photo")
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(fileURLs: $fileListModel.files)
                        }
                    }
                  
                
                    }.padding(.leading, 20)
                    .padding(.trailing, 20)
      
            List([viewModel.response].compactMap { $0 }, id: \.clientId) {
                clientObject in
                
                VStack(alignment: .leading) {
                    
                       
                    Text("**Адрес**: \(clientObject.address ?? "")")
                    Text("**ИИН**: \(String(clientObject.clientIin ?? 0))")
                    Text("**Поле**: \(clientObject.plotName ?? "Нету")")
                    Text("**Цель встречи**: \(client.visitTypeName ?? "")")
                    Text("**Место встречи**: \(clientObject.meetingTypeName ?? "")")
                    Text("**Сумма контрактов за последние три года**:\n \(clientObject.summContract ?? "")")
                    Text("**Сумма контрактов за текущий сезон**:\n \(clientObject.summCurrentContractSeason ?? "")")
                    Text("**Сумма субсидий за три года**:\n \(clientObject.subscidesSum ?? "")")
                    Divider()
                        .padding(.vertical, 10)
                    // Displaying ContactInf
                    VStack(alignment: .leading){
                        
                        ForEach(clientObject.contactInf ?? []) { contact in
                            VStack(alignment: .leading) {
                                Text("Контакты клиента:")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text(contact.name ?? "")
                                    .bold()
                                    .lineLimit(nil)
                                Text("**Телефон**: \(contact.phNumber ?? "")")
                                if let email = contact.email {
                                    Text("**Почта**: \(email)")
                                }
                                Text("**Должность**: \(contact.position ?? "")")
                               
                            
                            }
                        }
                      
                        
                    }
                    
                    
                    
                }
                ScrollView{
                    VStack(alignment: .leading, spacing: 3) {
                        Spacer()
                        NavigationLink(
                            destination: GetContract(),
                            label: {
                                Text("Контракты")
                                    .fontWeight(.bold)
                                    .padding(5)
                                    
                                    .foregroundColor(.white)
                                    .frame(width: 330, height: 38)
                                    .background(Color("purple"))
                                    .clipShape(Rectangle()).cornerRadius(7)
                                
                            })
                        Spacer()
                        NavigationLink(
                            destination: GetSubscidesList(),
                            label: {
                                Text("Список субсидий")
                                    .fontWeight(.bold)
                                    .padding(5)
                                
                                .foregroundColor(.white)
                                .frame(width: 330, height: 38)
                                .background(Color("purple"))
                                .clipShape(Rectangle()).cornerRadius(7)
                            
                            })
                        Spacer()
                        NavigationLink(
                            destination: SeasonCropView(),
                            label: {
                                Text("Севооборот клиента")
                                    .fontWeight(.bold)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .frame(width: 330, height: 38)
                                    .background(Color("purple"))
                                    .clipShape(Rectangle()).cornerRadius(7)
                                
                               
                            })
                        Spacer()
                        NavigationLink(
                            destination: CAView(),
                            label: {
                                Text("Анализ контрактов")
                                    .fontWeight(.bold)
                                    .padding(5)
                                    .foregroundColor(.white)
                                    .frame(width: 330, height: 38)
                                    .background(Color("purple"))
                                    .clipShape(Rectangle()).cornerRadius(7)
                                
                            })
                    }
                }


                
            }
            
            
            .onAppear {
                viewModel.fetchData()
                ClientIdManager.shared.setCurrentClientId(id: client.clientId)
                ClientVisitTypeNameManager.shared.setCurrentClientVisitTypeName(name: client.visitTypeName ?? "")
            }
            
        }
    }


/*
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
 */

  /*
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
   */
