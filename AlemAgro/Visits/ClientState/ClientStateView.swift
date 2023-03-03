//
//  ClientStateView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import SwiftUI
import Combine
struct ClientStateView: View {
    @StateObject private var vm = ClientStateViewModel()
    @StateObject private var viewModel = ContentViewModel()
    var body: some View {

            VStack {
                if let combinedData = viewModel.combinedData {
                    List{
                        ForEach(combinedData, id: \.id) { data in
                            //      List{
                            //   ForEach(viewModel.combinedData ?? [], id: \.id){
                            //      data in
                           
                                
                                Text("****: \(data.company)")
                                Text("**Дата**: \((data.time).formatted(.dateTime.day().month()))")
                                Text("**Район**: \(data.district)")
                            Text("**Потенциал**: \(data.potential) тг")
                            Text("**Проникновение АА**: \(data.pa) %")
                            Text("**Количество Визитов**: \(data.visitsQty)")
                            Text("**Cумма Закл Договоров**: \((data.potential)/100*10) 10% от потенциала")
                            
                            
                        }
                    }
                }
                else {
                                ProgressView()
                            }
             
            
        }
        .onAppear {
            viewModel.fetchData()
            
        }
        
    }

}
    

        
        class ContentViewModel: ObservableObject {
            
            @Published var combinedData: [CombinedData]?
            
            private var cancellables = Set<AnyCancellable>()
      
            func fetchData() {
                let api1 = URLSession.shared.dataTaskPublisher(for: URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/datab/posts")!)
                    .map { $0.data }
                    .decode(type: [User].self, decoder: JSONDecoder())
                
                let api2 = URLSession.shared.dataTaskPublisher(for: URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts")!)
                    .map { $0.data }
                    .decode(type: [ClientSt].self, decoder: JSONDecoder())
                
                Publishers.Zip(api1, api2)
                    .map {(User, ClientSt) in
                        User.compactMap { api1Item in
                            ClientSt.first(where: { $0.id == api1Item.id })
                                .map { api2Item in
                                    CombinedData(id: api1Item.id, company: api1Item.company, time:  api1Item.time, district: api2Item.district, potential: api2Item.potential, pa: api2Item.pa, visitsQty: api2Item.visitsQty)
                                }
                        }
                    }
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .finished:
                            break
                        }
                    } receiveValue: { [weak self] combinedData in
                        self?.combinedData = combinedData
                    }
                    .store(in: &cancellables)
            }
            
 
        }
        
        
        struct CombinedData: Identifiable, Codable {
            var id: Int
            var company: String
            var time: Date = Date()
            var district: String
            var potential: Int
            var pa: Int
            var visitsQty: Int
        }
        
        
    

