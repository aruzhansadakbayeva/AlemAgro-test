//
//  ClientStateViewModel.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import SwiftUI

final class ClientStateViewModel: ObservableObject {
    @Published var clientstates: [ClientSt] = []
    @Published var hasError = false
    @Published var error: ClientStError?
    @Published private(set) var isRefreshing = false
    func fetchClientSt(){
        isRefreshing = true
        hasError = false
        let clientstateUrlString = "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/"
        if let url = URL(string: clientstateUrlString){
            URLSession
                .shared
                .dataTask(with: url){ [weak self]
                    data, response, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if let error = error {
                            
                        } else {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            if let data = data,
                               let clientstates = try? decoder.decode([ClientSt].self, from: data){
                                self?.clientstates = clientstates
                            } else {
                                self?.hasError = true
                                self?.error = ClientStError.failedToDecode
                            }
                        }
                        self?.isRefreshing = false
                    }
                  
                    
                }.resume()
        }
    }
}

extension ClientStateViewModel{
    enum ClientStError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        var errorDescription: String?{
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
