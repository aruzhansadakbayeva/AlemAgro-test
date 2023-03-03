//
//  UserView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.02.2023.
//

import SwiftUI

struct UserView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("**Клиенты**: \(user.company)")
                NavigationLink("Клиенты", destination: ClientStateView())
                               
               
            }
            Text("**Цель визита**: \(user.goal)")
            Text("**Статус**: \(user.status)")
            Text("**Дата**: \(user.time.formatted(.dateTime.day().month()))")
            Divider()
   
            
        }.frame(maxWidth: .infinity, alignment: .leading).padding().background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous)).padding(.horizontal, 4)
    }
  
}

