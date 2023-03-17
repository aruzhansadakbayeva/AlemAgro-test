//
//  ContentView.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
  
    var title: String = "Профиль"
    var body: some View {
        NavigationView {
            VStack{
                Text("Hello, navigation!").padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Проекты")
                        .foregroundColor(Color.white).fontWeight(.bold)
                }
                
                
            }
            .navigationBarTitle("Проекты", displayMode: .inline)

     


                 .toolbarBackground(Color("purple"), for: .navigationBar)
                 .toolbarBackground(.visible, for: .navigationBar)
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
