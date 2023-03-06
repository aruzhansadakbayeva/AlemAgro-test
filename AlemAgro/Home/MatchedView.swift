//
//  MatchedView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 24.02.2023.
//

import SwiftUI

import SwiftUI

struct MatchedView: View {

    var body: some View {
        VStack(spacing: -20){
            HStack(spacing: 14){
                Image(systemName: "person.circle").resizable()
                    .frame(width: 40, height: 40)
              
                VStack(alignment: .leading, spacing: 2){
                    Text("Профиль") .fontWeight(.bold)
                    Text("Профиль пользователя").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: ContentView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(Color("grey"))
                .background(Color(.white))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
            HStack(spacing: 14){
                Image(systemName: "person.2.circle.fill").resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 2){
                    Text("Клиенты") .fontWeight(.bold)
                    Text("Список клиентов").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: ClientView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(Color("grey"))
                .background(Color(.white))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
            HStack(spacing: 14){
                Image(systemName: "calendar.badge.clock").resizable()
                    .frame(width: 40, height: 35)
                VStack(alignment: .leading, spacing: 2){
                    Text("Визиты") .fontWeight(.bold)
                    Text("Визиты к клиентам").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: ClientStateView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(Color("grey"))
                .background(Color(.white))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
        }
    }
}

