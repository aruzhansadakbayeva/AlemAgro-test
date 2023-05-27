//
//  Difficulties.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.03.2023.
//

import SwiftUI

struct ContractComplication: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: ContractComplication, rhs: ContractComplication) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


class ContractComplicationViewModel: ObservableObject {
    @Published var response: [ContractComplication] = []
    @Published var otherValue: String = ""
    func fetchData() {
        let urlString = "http://localhost:5001/api/meetings"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "meetingSurvey", "action": "getHandBookContractComplications"]
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
                let decodedResponse = try JSONDecoder().decode([ContractComplication].self, from: data)
                DispatchQueue.main.async {
                    self.response = decodedResponse
                }
            } catch let error {
                print("Error decoding response: \(error)")
            }
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}

struct Difficulties: View {

    @StateObject var viewModel = ContractComplicationViewModel()
    @State var selectedItems = Set<ContractComplication>()
    var isNextButtonEnabled: Bool {
         return !selectedItems.isEmpty
     }
    var body: some View {
        VStack{
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                HStack {
                    Text("\(item.name)")
                    if item.name == "Другое" {
                        TextField("Введите значение", text: $viewModel.otherValue)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                    }
                    Spacer()
                    if selectedItems.contains(item) {
                    
                        Image(systemName:"checkmark.square.fill")
                            .foregroundColor(.blue)
                    }
                    if !selectedItems.contains(item) {
                        Image(systemName:"square")
                            .foregroundColor(.blue)
                    }
                }
                
                
                .onTapGesture {
                    if selectedItems.contains(item) {
                        selectedItems.remove(item)
                        SelectedItemsManager.selectedItems3.remove(item) // удаляем элемент из SelectedItemsManager
                        print("Удален элемент: \(item.name)")
                    } else {
                        selectedItems.insert(item)
                        SelectedItemsManager.selectedItems3.insert(item) // добавляем элемент в SelectedItemsManager
                        print("Добавлен элемент: \(item.name)")
                    }
                   
                }
        
            }
      
            .navigationBarTitle("Cложности закл-ия договора")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Recommendations()) {
                    Text("Далее")
                }
                .disabled(!isNextButtonEnabled)
            )
        }
        
        .onAppear {
            viewModel.fetchData()
        }

    }
}

struct Difficulties2: View {
    @ObservedObject var viewModel2 = FieldInspectionViewModel.shared
    @StateObject var viewModel = ContractComplicationViewModel()
    @State var selectedItems = Set<ContractComplication>()
    var isNextButtonEnabled: Bool {
         return !selectedItems.isEmpty
     }
    var body: some View {
        VStack{
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                HStack {
                    Text("\(item.name)")
                    if item.name == "Другое" {
                        TextField("Введите значение", text: $viewModel.otherValue)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                    }
                    Spacer()
                    if selectedItems.contains(item) {
                    
                        Image(systemName:"checkmark.square.fill")
                            .foregroundColor(.blue)
                    }
                    if !selectedItems.contains(item) {
                        Image(systemName:"square")
                            .foregroundColor(.blue)
                    }
                }
                
                
                .onTapGesture {
                    if selectedItems.contains(item) {
                        selectedItems.remove(item)
                        SelectedItemsManager.selectedItems3.remove(item) // удаляем элемент из SelectedItemsManager
                        print("Удален элемент: \(item.name)")
                    } else {
                        selectedItems.insert(item)
                        SelectedItemsManager.selectedItems3.insert(item) // добавляем элемент в SelectedItemsManager
                        print("Добавлен элемент: \(item.name)")
                    }
                   
                }
        
            }
      
            .navigationBarTitle("Cложности закл-ия договора")
            .navigationBarItems(trailing:
                                    NavigationLink(destination:  SelectedItemsView(selectedItemsHistory: viewModel2.selectedItemsHistory)) {
                    Text("Далее")
                }
                .disabled(!isNextButtonEnabled)
            )
        }
        
        .onAppear {
            viewModel.fetchData()
        }

    }
}
struct Difficulties3: View {

    @StateObject var viewModel = ContractComplicationViewModel()
    @State var selectedItems = Set<ContractComplication>()
    var isNextButtonEnabled: Bool {
         return !selectedItems.isEmpty
     }
    var body: some View {
        VStack{
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                HStack {
                    Text("\(item.name)")
                    if item.name == "Другое" {
                        TextField("Введите значение", text: $viewModel.otherValue)
                            .padding(.horizontal, 10)
                            .frame(height: 50)
                    }
                    Spacer()
                    if selectedItems.contains(item) {
                    
                        Image(systemName:"checkmark.square.fill")
                            .foregroundColor(.blue)
                    }
                    if !selectedItems.contains(item) {
                        Image(systemName:"square")
                            .foregroundColor(.blue)
                    }
                }
                
                
                .onTapGesture {
                    if selectedItems.contains(item) {
                        selectedItems.remove(item)
                        SelectedItemsManager.selectedItems3.remove(item) // удаляем элемент из SelectedItemsManager
                        print("Удален элемент: \(item.name)")
                    } else {
                        selectedItems.insert(item)
                        SelectedItemsManager.selectedItems3.insert(item) // добавляем элемент в SelectedItemsManager
                        print("Добавлен элемент: \(item.name)")
                    }
                   
                }
        
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Cложности закл-ия договора")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Recommendations()) {
                    Text("Далее")
                }
                .disabled(!isNextButtonEnabled)
            )
        }
        
        .onAppear {
            viewModel.fetchData()
        }

    }
}
