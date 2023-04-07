//
//  Test3.swift
//  AlemAgro
//
//  Created by Aruzhan  on 14.03.2023.
//


import SwiftUI

struct PostmanResponse: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: PostmanResponse, rhs: PostmanResponse) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

class PostmanViewModel: ObservableObject {
    @Published var response: [PostmanResponse] = []
    @Published var selectedItems: Set<PostmanResponse> = []
    @Published var otherValue: String = ""
    
    var nextView: AnyView?
    
    func fetchData() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "meetingSurvey", "action": "getHandBookWorkDone"]
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
                let decodedResponse = try JSONDecoder().decode([PostmanResponse].self, from: data)
                DispatchQueue.main.async {
                    self.response = decodedResponse
                }
            } catch let error {
                print("Error decoding response: \(error)")
            }
           // print(String(data: data, encoding: .utf8)!)
        }.resume()
    }


    func getNextViewCombined(for item: PostmanResponse) -> AnyView {
        let currentClientVisitTypeName = ClientVisitTypeNameManager.shared.getCurrentClientVisitTypeName() ?? ""
        var viewsToReturn: [AnyView] = []

        if item.name == "Осмотр поля" || currentClientVisitTypeName == "Осмотр полей" {
            viewsToReturn.append(AnyView(FView()))
        }

        if item.name == "Предложение КП" || currentClientVisitTypeName == "Предложение КП" || currentClientVisitTypeName == "Заключение договора" {
            viewsToReturn.append(AnyView(Difficulties()))
        }

        if viewsToReturn.isEmpty {
            viewsToReturn.append(AnyView(Recommendations()))
        }

        return AnyView(PresentationView(viewsToReturn: viewsToReturn))
    }




}

struct PresentationView: View {
    @State private var currentIndex = 0
    let viewsToReturn: [AnyView]

    init(viewsToReturn: [AnyView]) {
        self.viewsToReturn = viewsToReturn
    }

    var body: some View {
        VStack {
            // Отображение текущего представления на основе индекса
            viewsToReturn[currentIndex]

            // Кнопка "Далее"
            Button(action: {
                currentIndex += 1
                // Если достигнут конец массива, вернуться на первое представление
                if currentIndex >= viewsToReturn.count {
                    currentIndex = 0
                }
            }) {
                Text("Далее")
            }
        }
    }
}
struct SelectVisitView: View {
   
    @StateObject var viewModel = PostmanViewModel()
    @State var selectedItems = Set<PostmanResponse>()
    var isNextButtonEnabled: Bool {
        return !viewModel.selectedItems.isEmpty
    }
    
    var body: some View {
        List(viewModel.response, id: \.id, selection:  $viewModel.selectedItems) { item in
            HStack {
                Text("\(item.name)")
                if item.name == "Другое" {
                    TextField("Введите значение", text: $viewModel.otherValue)
                        .padding(.horizontal, 10)
                        .frame(height: 50)
                }
                Spacer()
                
                
                if viewModel.selectedItems.contains(item) {
                    Image(systemName:"checkmark.square.fill")
                        .foregroundColor(.blue)
                    
                    
                }
                if !viewModel.selectedItems.contains(item) {
                    Image(systemName:"square")
                        .foregroundColor(.blue)
                }
                
            }
            .onTapGesture {
                if viewModel.selectedItems.contains(item) {
                    viewModel.selectedItems.remove(item)
                    SelectedItemsManager.selectedItems.remove(item) // удаляем элемент из SelectedItemsManager
                    print("Удален элемент: \(item.name)")
                } else {
                    viewModel.selectedItems.insert(item)
                    SelectedItemsManager.selectedItems.insert(item) // добавляем элемент в SelectedItemsManager
                    print("Добавлен элемент: \(item.name)")
                }
                viewModel.nextView = viewModel.getNextViewCombined(for: item)
            }
            
            .navigationBarTitle("Проделанная работа")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: viewModel.nextView ?? AnyView(Recommendations())) { // Используем функцию getNextView2() для определения следующего окна
                                         Text("Далее")
            }
                .disabled(!isNextButtonEnabled)
            )
            
        }
        .onAppear {
            viewModel.fetchData()
             
         //   WorkDoneManager.shared.setWorkDone(name: )
                
        }
        
    }
    
}
    /*
    func sendVisitIdToAPI2() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }

        let selectedIds = viewModel.selectedItems.map { $0.id }
        let workDone = selectedIds.isEmpty ? [] : selectedIds
        
        let parameters: [String: Any] = [
            "type": "meetingSurvey",
            "action": "fixedSurvey",
            "visitId": visitId,
            "workDone": workDone
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
     */





