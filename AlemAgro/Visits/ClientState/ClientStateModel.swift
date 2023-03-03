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
    
}
