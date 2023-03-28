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
    static var selectedItems = Set<PostmanResponse>() {
        didSet {
            print("Выбранные элементы: \(SelectedItemsManager.selectedItems)")
        }
    }
}

struct SelectedItemsView: View {
    
    var body: some View {
        
        List {
            ForEach(Array(SelectedItemsManager.selectedItems), id: \.id) { item in
                Text("\(item.name)")
            }
            ForEach(Array(SelectedItemsManager.selectedItems2), id: \.id) { item in
                Text("\(item.name)")
            }
            ForEach(Array(SelectedItemsManager.selectedItems3), id: \.id) { item in
                Text("\(item.name)")
            }
            ForEach(SelectedItemsManager.selectedOptions.sorted(by: { $0.key.id < $1.key.id }), id: \.key.id) { item in
                HStack {
                    Text("\(item.key.name): ")
                    Text("\(item.value)")
                }
            }
        }
    }
}
