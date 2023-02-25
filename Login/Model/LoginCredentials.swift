//
//  LoginCredentials.swift
//  BCR
//
//  Created by Aruzhan  on 17.12.2022.
//

import Foundation
struct LoginCredentials {
    
    var email: String
    var password: String
}
extension LoginCredentials {
    
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
