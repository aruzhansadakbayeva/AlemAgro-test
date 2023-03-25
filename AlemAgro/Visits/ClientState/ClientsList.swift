//
//  ClientsList.swift
//  AlemAgro
//
//  Created by Aruzhan  on 16.03.2023.
//

import SwiftUI

struct ClientsList: View {
    let client: Clientt

    var body: some View {
  
            VStack(alignment: .leading){
                Text("**Компания**: \(client.clientName)")
                Text("**Дата**: \(client.dateVisit)")
                Text("**ИИН/Бин**: \(client.clientIin)")
                
                Text("**Адрес**: \(client.clientAddress ?? "")")
                Text("**Тип встречи**: \(client.meetingTypeName ?? "")")
            }
    }
    }
    
    
