//
//  ClientInfo.swift
//  AlemAgro
//
//  Created by Aruzhan  on 23.02.2023.
//


import Foundation
import SwiftUI


struct Client: Identifiable, Hashable, Decodable{
    var id: Int
    var Row: Int
    var clientName: String
    var sumClient: Double
    var clientIin: Int
    var clientAddress: String

}
