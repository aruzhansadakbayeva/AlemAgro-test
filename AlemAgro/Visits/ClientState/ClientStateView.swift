//
//  ClientStateView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import SwiftUI
import Combine
struct ClientStateView: View {
    //@StateObject private var vm = ClientStateViewModel()
    @State private var selectedDate = Date()
    @StateObject var viewModel = ContentViewModel()
    @State private var selectdDate = Date()
    @State var filteredData: [CombinedData] = []
    @State var selectedID: Int? = nil


    var body: some View {
      
            VStack {
                DatePicker(
                    "",
                    selection: $selectdDate,
                    displayedComponents: [.date]
                )
                .padding()
                
                VStack(alignment: .leading){
                    List{
                        ForEach(filteredUsers(), id: \.id) { data in

                  
                                Text("**Клиенты**: \(data.company)")
                                Text("**Цель визита**: \(data.goal)")
                                Text("**Статус**: \(data.status)")
                                Text("**Дата**: \(data.time.formatted(.dateTime.day().month()))")
                                
                                
                          
                                NavigationLink(destination:
                                                ClientStView(data: data)){
                                 
                                    Label: do {
                                            Text("Детали")
                                        }
                                    ForEach(viewModel.filteredData, id: \.id) { data in
                                    
                                    //   ClientStView(data: data)
                                    
                                }
                            }
                            
                        }
                   }.listStyle(.plain)
              

                  //  ClientStView(data: data) .listRowSeparator(.hidden)}
                } /*.frame(maxWidth: .infinity, alignment: .leading).padding().background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous)).padding(.horizontal, 4)
                
                */
                if let combinedData = viewModel.combinedData {
                    /*  List{
                     ForEach(viewModel.filteredData, id: \.id) { data in
                     //      List{
                     //   ForEach(viewModel.combinedData ?? [], id: \.id){
                     //      data in
                     
                     ClientStView(data: data)
                     .listRowSeparator(.hidden)
                     
                     /*   Text("****: \(data.company)")
                      Text("**Дата**: \((data.time).formatted(.dateTime.day().month()))")
                      Text("**Район**: \(data.district)")
                      Text("**Потенциал**: \(data.potential) тг")
                      Text("**Проникновение АА**: \(data.pa) %")
                      Text("**Количество Визитов**: \(data.visitsQty)")
                      Text("**Cумма Закл Договоров**: \((data.potential)/100*10) 10% от потенциала")
                      */
                     
                     }
                     }.listStyle(.plain) */
                     
                     }
                    else {
                        ProgressView()
                    }
          
                
            }
            
            .onAppear {
                viewModel.fetchData()
                
            }
        
    }

    private func filteredUsers() -> [CombinedData] {
        return viewModel.combinedData.filter {
            Calendar.current.isDate($0.time, inSameDayAs: selectdDate)
        }
    }
    
    
}
    

    
    class ContentViewModel: ObservableObject {
        
        @Published var combinedData: [CombinedData] = []
        @Published var filteredData: [CombinedData] = []
         @Published var selectedID: Int? = nil
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
                                CombinedData(id: api1Item.id, company: api1Item.company, goal: api1Item.goal, status: api1Item.status, time:  api1Item.time, district: api2Item.district, potential: api2Item.potential, pa: api2Item.pa, visitsQty: api2Item.visitsQty, isFlagged: api2Item.isFlagged, timestamp: api2Item.timestamp, main_goal: api2Item.main_goal)
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
        

        
        func filterData() {
            if let id = selectedID {
                filteredData = combinedData.filter { $0.id == id }
            } else {
                filteredData = combinedData
            }
        }
        
    

}
    struct CombinedData: Identifiable, Codable {
        var id: Int
        var company: String
        var goal: String
        var status: String
        var time: Date = Date()
        var district: String
        var potential: Int
        var pa: Int
        var visitsQty: Int
        var isFlagged: Bool
        var timestamp: Date = Date()
        var main_goal: String

    }
    
    


