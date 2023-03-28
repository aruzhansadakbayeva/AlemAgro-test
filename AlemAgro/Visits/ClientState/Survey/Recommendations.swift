//
//  Recommendations.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.03.2023.
//

import SwiftUI

struct PostmanResponse4: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: PostmanResponse4, rhs: PostmanResponse4) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


class PostmanViewModel4: ObservableObject {
    @Published var response: [PostmanResponse4] = []
    
    func fetchData() {
        let urlString = "http://10.200.100.17/api/manager/workspace"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "meetingSurvey", "action":"getHandBookMeetingRecommendations"]
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
                let decodedResponse = try JSONDecoder().decode([PostmanResponse4].self, from: data)
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

struct Recommendations: View {
    @StateObject var viewModel = PostmanViewModel4()
    @State var selectedItems = Set<PostmanResponse4>()
   
    var body: some View {
 
        List(viewModel.response, id: \.id, selection: $selectedItems) { item in
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
        .onAppear {
            viewModel.fetchData()
        }
    }
}


