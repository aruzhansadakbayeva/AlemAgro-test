//
//  OsmotrPolya.swift
//  AlemAgro
//
//  Created by Aruzhan  on 20.03.2023.
//

import SwiftUI

struct PostmanResponse2: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    var category: String
    var categoryId: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: PostmanResponse2, rhs: PostmanResponse2) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.categoryId == rhs.categoryId && lhs.category == rhs.category
    }
}


class PostmanViewModel2: ObservableObject {
    @Published var response: [PostmanResponse2] = []
    @Published var selectedItems = Set<PostmanResponse2>()


    var categorizedResponse: [String: [PostmanResponse2]] {
         Dictionary(grouping: response, by: { $0.category })
     }
    
     func fetchData() {
         let urlString = "http://10.200.100.17/api/manager/workspace"
         guard let url = URL(string: urlString) else {
             fatalError("Invalid URL: \(urlString)")
         }
                 
         let parameters = ["type": "meetingSurvey", "action": "getHandBookFieldInsp"]
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
                 let decodedResponse = try JSONDecoder().decode([PostmanResponse2].self, from: data)
                 DispatchQueue.main.async {
                     self.response = decodedResponse
                 }
             } catch let error {
                 print("Error decoding response: \(error)")
             }
            // print(String(data: data, encoding: .utf8)!)
         }.resume()
     }
}

struct FieldView: View {
    @Environment(\.colorScheme) var colorScheme

    var colorPrimary: Color {
        return colorScheme == .dark ? .black : .white
    }
    @StateObject var viewModel = PostmanViewModel2()
    @State var counter: Int



    init(counter: Int) {
        self._counter = State(initialValue: counter)
    }

    var isNextButtonEnabled: Bool {
        return !viewModel.selectedItems.isEmpty
     }
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("view number: \(counter)")
                NavigationLink(destination: FieldView(counter: counter + 1)) {
                    Text("Добавить культуру")
                }
                ForEach(viewModel.categorizedResponse.sorted(by: { $0.value[0].categoryId < $1.value[0].categoryId }), id: \.key) { category, items in
        
             
                    Section(header: Text(category).fontWeight(.bold).foregroundColor(Color.primary)) {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(items, id: \.id) { item in
                                    VStack {
                                        Image("\(item.name)")
                                            .resizable()
                                            .frame(width: 110, height: 110)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                           //.overlay(Circle().stroke(Color.white, lineWidth: 2))
                                        Text("\(item.name)").font(.system(size: 14)).foregroundColor(Color.primary)
                                    }
                                    .background(colorPrimary)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        if item.categoryId == 3 { // Множественная выборка для items третьей категории
                                            if viewModel.selectedItems.contains(item){
                                                viewModel.selectedItems.remove(item)
                                                SelectedItemsManager.selectedCategoryIds.remove(item.categoryId)
                                                SelectedItemsManager.selectedItems2.remove(item)
                                            } else {
                                                viewModel.selectedItems.insert(item)
                                                SelectedItemsManager.selectedItems2.insert(item)
                                                SelectedItemsManager.selectedCategoryIds.insert(item.categoryId)
                                            }
                                        }
                                        else if viewModel.selectedItems.contains(item)  {
                                            
                                            viewModel.selectedItems.remove(item)
                                            SelectedItemsManager.selectedCategoryIds.remove(item.categoryId) // удаляем categoryId из selectedCategoryIds
                                            SelectedItemsManager.selectedItems2.remove(item) // удаляем элемент из SelectedItemsManager
                                            
                                            print("Удален элемент: \(item.name)")
                                        } else {
                                            let itemsToRemove = viewModel.selectedItems.filter { $0.categoryId == item.categoryId }
                                            viewModel.selectedItems.subtract(itemsToRemove)
                                            SelectedItemsManager.selectedItems2.subtract(itemsToRemove)
                                            viewModel.selectedItems.insert(item)
                                            SelectedItemsManager.selectedCategoryIds.insert(item.categoryId) // добавляем categoryId в selectedCategoryIds
                                            SelectedItemsManager.selectedItems2.insert(item) // добавляем элемент в SelectedItemsManager
                                            
                                            print("Добавлен элемент: \(item.name)")
                                        }
                               
                                        
                                        print("Selected categoryIds: \(SelectedItemsManager.selectedCategoryIds)") // выводим выбранные categoryId в консоль
                                        print("Selected items: \(viewModel.selectedItems)")
                                       
                                    }

                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(viewModel.selectedItems.contains(item) ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                }
            }
        

            .navigationBarTitle("Осмотр поля")
                        .navigationBarItems(
                                        trailing:
                                            

                                           
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


struct FView: View{
    @State var counter: Int = 0
    var body: some View{
        VStack{
       FieldView(counter: counter + 1)
            
        }
    }
}


/*   if viewModel.selectedItems.contains(item) {
 viewModel.selectedItems.remove(item)
 SelectedItemsManager.selectedCategoryIds.remove(item.categoryId) // удаляем categoryId из selectedCategoryIds
 SelectedItemsManager.selectedItems2.remove(item) // удаляем элемент из SelectedItemsManager

 print("Удален элемент: \(item.name)")
} else {
 viewModel.selectedItems.insert(item)
 SelectedItemsManager.selectedCategoryIds.insert(item.categoryId) // добавляем categoryId в selectedCategoryIds
 SelectedItemsManager.selectedItems2.insert(item) // добавляем элемент в SelectedItemsManager

 print("Добавлен элемент: \(item.name)")
}
 */


/*
 
 
 
 
 if viewModel.selectedItems.contains(item) {
     viewModel.selectedItems.remove(item)
     SelectedItemsManager.selectedItems2.remove(item)
 } else {
     // Remove previously selected items from the same category
     let itemsToRemove = viewModel.selectedItems.filter { $0.categoryId == item.categoryId }
     viewModel.selectedItems.subtract(itemsToRemove)
     SelectedItemsManager.selectedItems2.subtract(itemsToRemove)

     // Add the newly selected item
     viewModel.selectedItems.insert(item)
     SelectedItemsManager.selectedItems2.insert(item)
 }

 */
