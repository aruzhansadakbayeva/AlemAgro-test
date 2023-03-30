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

    
    var body: some View {
        Button(action: {
       
            sendToAPI()
            
        }) {Text("Send") }
        List {
            ForEach(Array(SelectedItemsManager.selectedItems), id: \.id) { item in
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
            
        
            // Iterate over selectedCategoryIds and display selectedItems2 for each category
            ForEach(Array(SelectedItemsManager.selectedCategoryIds), id: \.self) { categoryId in
                Section(header: Text("Selected Items for cultId \(categoryId)")) {
                    ForEach(Array(SelectedItemsManager.selectedItems2.filter({ $0.categoryId == categoryId })), id: \.id) { item in
                        Text("\(item.name)")
                    }
                }
            }
        }
    }


    
    func sendToAPI() {
        let currentVisitId = VisitIdManager.shared.getCurrentVisitId() ?? 0
print("Current visit id: \(currentVisitId)")
  

        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        let workDoneIds = SelectedItemsManager.selectedItems.map { $0.id }
        let fieldInspection = Array(SelectedItemsManager.selectedCategoryIds).map { categoryId -> [String: Any] in
            let services = Array(SelectedItemsManager.selectedItems2.filter { $0.categoryId == categoryId }).map { item -> [String: Any] in
                return [
                    "typeId": item.id,
                    "description": item.name
                ]
            }
            
            return [
                "cultId": categoryId,
                "services": services
            ]
        }
    
            let parameters = [
                "type": "meetingSurvey",
                "action": "fixedSurvey",
                "visitId": currentVisitId,
                "workDone": workDoneIds,
                "fieldInspection": fieldInspection,
                "contractComplication": SelectedItemsManager.selectedItems3.map { item -> [String: Any] in
                    return [
                        "typeId": item.id,
                        "description": item.name
                    ]
                },
                "recomendation": SelectedItemsManager.selectedOptions.map { item -> [String: Any] in
                    return [
                        "typeId": item.key.id,
                        "description": item.value,
                    ]
                },
                "fileVisit": "dsasdsa"] as [String : Any]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Parameters: \(parameters)")
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }

    
 
    
    
}
