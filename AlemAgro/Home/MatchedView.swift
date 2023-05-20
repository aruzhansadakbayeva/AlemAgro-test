//
//  MatchedView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 24.02.2023.
//

import SwiftUI

struct MatchedView: View {

    var body: some View {
        Spacer()
        VStack(spacing: -20){
            HStack(spacing: 14){
                Image(systemName: "person.circle").resizable()
                    .frame(width: 40, height: 40)
              
                VStack(alignment: .leading, spacing: 2){
                    Text("Профиль") .fontWeight(.bold)
                    Text("Профиль пользователя").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: ProfileView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(.primary)
                .background(Color(.systemBackground))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 1)
            /*
            HStack(spacing: 14){
                Image(systemName: "person.2.circle.fill").resizable()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 2){
                    Text("Клиенты") .fontWeight(.bold)
                    Text("Список клиентов").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: ContentView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(.primary)
                .background(Color(.systemBackground))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 1)
             */
            
            HStack(spacing: 14){
                Image(systemName: "calendar.badge.clock").resizable()
                    .frame(width: 40, height: 35)
                VStack(alignment: .leading, spacing: 2){
                    Text("Встречи") .fontWeight(.bold)
                    Text("Встречи с клиентами").font(.system(size: 15)).font(.footnote)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: VisitListView()){
                label: do {
                    Image(systemName: "chevron.right").font(.title2)
                }
                }
            }.padding(15).foregroundStyle(.primary)
                .background(Color(.systemBackground))
                .clipShape(Rectangle()).cornerRadius(5).padding(15)
                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 1)
        }.background(Color(.systemBackground)).padding(.horizontal)

    }
}



