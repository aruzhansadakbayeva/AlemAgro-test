//
//  SIManager.swift
//  AlemAgro
//
//  Created by Aruzhan  on 28.03.2023.
//

import Foundation
import SwiftUI

class SelectedItemsManager {

    static var selectedOptions: [PostmanResponse4: String] = [:]
    static let shared = SelectedItemsManager()
    static var selectedItems3 = Set<PostmanResponse3>() {
        didSet {
            print("Выбранные элементы: \(SelectedItemsManager.selectedItems)")
        }
    }
    static var selectedItems2 = Set<PostmanResponse2>() {
        didSet {
            print("Выбранные элементы: \(SelectedItemsManager.selectedItems2)")
        }
    }

    static var selectedCategoryIds = Set<Int>()
    
    static var selectedItems = Set<PostmanResponse>() {
        didSet {
            print("Выбранные элементы: \(SelectedItemsManager.selectedItems)")
        }
    }
}

struct SelectedItemsView: View {
    @StateObject var viewModel = PostmanViewModel2()
    var selectedItemsHistory: [[PostmanResponse2]]
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("Результат опроса:")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                VStack(alignment: .leading){
                    if (!selectedItemsHistory.isEmpty) {
                        Text("Осмотр поля:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                    }
                    ForEach(selectedItemsHistory.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Культура \(index + 1):").foregroundColor(.green)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            // Создаем словарь, где ключом будет категория, а значением - массив элементов
                            let itemsByCategory = Dictionary(grouping: selectedItemsHistory[index], by: { $0.category })
                            
                            ForEach(itemsByCategory.keys.sorted(), id: \.self) { category in
                                Text(category)
                                    .fontWeight(.bold)
                                
                                ForEach(itemsByCategory[category]!, id: \.id) { item in
                                    Text("- \(item.name)")
                                        .padding(.bottom, 5)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    
                    
                } .padding(.horizontal, 20)
                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading) {
                    Text("Проделанная работа:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    ForEach(Array(SelectedItemsManager.selectedItems), id: \.id) { item in
                        Text("- \(item.name)")
                            .padding(.bottom, 5)
                    }
                
                    if (!SelectedItemsManager.selectedItems3.isEmpty) {
                        Text("Сложности заключения договора:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                    }
                    ForEach(Array(SelectedItemsManager.selectedItems3), id: \.id) { item in
                   
                            Text("- \(item.name)")
                                .padding(.bottom, 5)
                        
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    Text("Рекомендации:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    ForEach(SelectedItemsManager.selectedOptions.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { item in
                        HStack {
                            Text("\(item.key.name)")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(item.value)")
                        }
                        .padding(.bottom, 5)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    
}
  
    

/*
      ForEach(Array(SelectedItemsManager.selectedCategoryIds), id: \.self) { categoryId in
          Section(header: Text("Selected Items for cultId \(categoryId)")) {
              ForEach(Array(SelectedItemsManager.selectedItems2.filter({ $0.categoryId == categoryId })), id: \.id) { item in
                  Text("\(item.name)")
              }
          }
      }
      */
