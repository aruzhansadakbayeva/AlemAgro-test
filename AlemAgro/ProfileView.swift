//
//  ProfileView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 17.03.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
   
        NavigationView {
            VStack{
                Text("Hello, navigation!").padding()
                Button(action: {
                    appState.isLoggedIn = false // Выход из аккаунта
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                })
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Профиль")
                        .foregroundColor(Color.white).fontWeight(.bold)
                }
            }
            .navigationBarTitle("Профиль", displayMode: .inline)
            .toolbarBackground(Color("purple"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
