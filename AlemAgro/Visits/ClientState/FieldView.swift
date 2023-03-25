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
            print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}

struct FieldView: View {
    @StateObject var viewModel = PostmanViewModel2()
    @State var selectedItems = Set<PostmanResponse2>()

    var body: some View {
        List(selection: $selectedItems) {
            ForEach(viewModel.categorizedResponse.sorted(by: { $0.key < $1.key }), id: \.key) { category, items in
                Section(header: Text(category)) {
                    ForEach(items, id: \.id) { item in
                        HStack {
                            Text("\(item.name)")
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
                            } else {
                                selectedItems.insert(item)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}
