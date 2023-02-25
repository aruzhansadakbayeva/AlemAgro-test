//
//  MatchedView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 24.02.2023.
//

import SwiftUI

struct MatchedView: View {
    @State var title: String = "Основные модули"
    var body: some View {
        VStack(alignment: .center){
            Text(title).font(.title2).foregroundColor(.white).fontWeight(.heavy).padding(20)
           
        VStack{
            
            VStack(alignment: .trailing, spacing: 12){
                Text("Личные данные менеджера").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: ContentView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("color3")).clipShape(Rectangle()).cornerRadius(20)
            }
            Spacer()
            Divider()
            VStack(alignment: .trailing, spacing: 12){
                Text("Клиенты").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: ContentView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("color3")).clipShape(Rectangle()).cornerRadius(20)
            }
            Spacer()
            Divider()
            VStack(alignment: .trailing, spacing: 12){
                Text("Календарь").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: ContentView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("color3")).clipShape(Rectangle()).cornerRadius(20)
            }
            Spacer()
            Divider()
            
            VStack(alignment: .trailing, spacing: 12){
                Text("Визиты").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: ContentView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("color3")).clipShape(Rectangle()).cornerRadius(20)
            }
            
        }.padding(20).foregroundStyle(.white)
            .background(Color("lightBlue")).clipShape(Rectangle()).cornerRadius(20)
            .padding(20)
    }
    }
        }
    


struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView()
    }
}
