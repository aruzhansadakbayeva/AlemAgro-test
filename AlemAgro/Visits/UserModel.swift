//
//  UserModel.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.02.2023.
//

import Foundation
import SwiftUI
struct User: Identifiable, Hashable, Codable {
    
    var id: Int
    var company: String
    var goal: String
    var status: String
    var time: Date = Date()
    
}


