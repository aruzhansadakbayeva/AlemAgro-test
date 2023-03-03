//
//  ClientState.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import SwiftUI
import Combine

struct ClientStView: View {

    //@ObservedObject var viewModel = ClientStateViewModel()
    var body: some View {
        VStack {
         
        }
    }
}
    /* func fetchUser(id: Int, completion: @escaping (User?) -> ()) {
     guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/datab/posts/\(id)") else {
     return
     }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     guard let data = data else {
     return
     }
     
     let decoder = JSONDecoder()
     do {
     let user = try decoder.decode(User.self, from: data)
     completion(user)
     } catch {
     print(error.localizedDescription)
     }
     }.resume()
     }
     
     func fetchPost(id: Int, completion: @escaping (ClientSt?) -> ()) {
     guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
     return
     }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     guard let data = data else {
     return
     }
     
     let decoder = JSONDecoder()
     do {
     let post = try decoder.decode(ClientSt.self, from: data)
     completion(post)
     } catch {
     print(error.localizedDescription)
     }
     }.resume()
     }
     }*/
    
    /*      func fetchData() {
     
     // Fetch data from first API
     let api1Url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts")!
     URLSession.shared.dataTask(with: api1Url) { data, response, error in
     
     guard let data = data, error == nil else {
     print("Error fetching data from API 1: \(error?.localizedDescription ?? "Unknown error")")
     return
     }
     
     do {
     let decodedData = try JSONDecoder().decode([ClientSt].self, from: data)
     DispatchQueue.main.async {
     self.data2.append(contentsOf: decodedData)
     }
     } catch {
     print("Error decoding data from API 1: \(error.localizedDescription)")
     }
     }.resume()
     
     // Fetch data from second API
     let api2Url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/datab/posts")!
     URLSession.shared.dataTask(with: api2Url) { data2, response, error in
     
     guard let data2 = data2, error == nil else {
     print("Error fetching data from API 2: \(error?.localizedDescription ?? "Unknown error")")
     return
     }
     
     do {
     let decodedData = try JSONDecoder().decode([ClientSt].self, from: data2)
     DispatchQueue.main.async {
     self.data2.append(contentsOf: decodedData)
     }
     } catch {
     print("Error decoding data from API 2: \(error.localizedDescription)")
     }
     }.resume()
     }
     func getDataById(_ id: Int) -> (User?, ClientSt?) {
     let api1Data = self.data.first(where: { $0.id == id })
     let api2Data = self.data2.first(where: { $0.id == id })
     return (api1Data, api2Data)
     }
     }
     */
    
    
    
    



    
