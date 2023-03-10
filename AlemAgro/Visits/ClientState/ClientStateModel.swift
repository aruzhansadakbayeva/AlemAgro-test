//
//  File.swift
//  AlemAgro
//
//  Created by Aruzhan  on 03.03.2023.
//

import Foundation
struct ClientSt: Identifiable, Hashable, Codable {
   
    var id: Int
    var district: String
    var potential: Int
    var pa: Int
    var visitsQty: Int
    var isFlagged: Bool
    var timestamp: Date = Date()
    var main_goal: String
    var culture: String
    var stages: String
    var problem_detection = [String]()
    
}
