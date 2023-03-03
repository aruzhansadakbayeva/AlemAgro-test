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
        
        VStack(alignment: .leading){
           // Text(title).font(.title2).foregroundColor(.white).fontWeight(.heavy).padding(20)
          
            VStack{
                    HStack{
                        Image(systemName: "person.crop.square").resizable()
                            .frame(width: 48, height: 48)
                       Text("Профиль") .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
         
                        NavigationLink(destination: ContentView()){
                        label: do {
                            Image(systemName: "chevron.right").font(.title2)
                        }
                        }}
                }.padding(10).foregroundStyle(Color("grey"))
                    .background(Color(.white))
                    .clipShape(Rectangle()).cornerRadius(5).padding(15)
                //
                //  .padding(20)
                Spacer(minLength: -5)
                VStack{
                    HStack{
                        VStack{Image(systemName: "person.2.fill").resizable()
                            .frame(width: 50, height: 34).scaledToFit()}
                            Text("Клиенты") .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink(destination: ClientView()){
                        label: do {
                            Image(systemName: "chevron.right").font(.title2)
                        }
                        }}
                }.padding(20).foregroundStyle(Color("grey"))
                    .background(Color(.white))
                    .clipShape(Rectangle()).cornerRadius(5).padding(15)
            Spacer(minLength: -5)
                VStack{
                    HStack{
                        VStack{Image(systemName: "calendar.badge.clock").resizable()
                            .frame(width: 58, height: 48).scaledToFit()}
                            Text("Визиты") .fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        NavigationLink(destination: VisitsView()){
                        label: do {
                            Image(systemName: "chevron.right").font(.title2)
                        }
                        }}
                }.padding(10).foregroundStyle(Color("grey"))
                    .background(Color(.white))
                    .clipShape(Rectangle()).cornerRadius(5).padding(15)
            Spacer(minLength: -5)
          
                    //.cornerRadius(20)
               // .padding(20)
            
          /*
          VStack(alignment: .trailing, spacing: 12){
          
              Spacer()
              HStack{
                  Text("Клиенты").font(.title2.weight(.bold))
                      .frame(maxWidth: .infinity, alignment: .leading)
                  NavigationLink(destination: ContentView()){
                      Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                  }
              }
            }
            Spacer()
            Divider()
            VStack(alignment: .trailing, spacing: 12){
                Text("Клиенты").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: ContentView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("lightBlue")).clipShape(Rectangle()).cornerRadius(20)
            }
            Spacer()
            Divider()
            VStack(alignment: .trailing, spacing: 12){
                Text("Календарь").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: VisitsView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("lightBlue")).clipShape(Rectangle()).cornerRadius(20)
            }
            Spacer()
            Divider()
            
            VStack(alignment: .trailing, spacing: 12){
                Text("Визиты").font(.title2.weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                NavigationLink(destination: VisitsView()){
                    Text("Перейти").font(.system(size: 13)).foregroundColor(.white).font(.body).fontWeight(.heavy).foregroundColor(.black).padding(7)
                }.background(Color("lightBlue")).clipShape(Rectangle()).cornerRadius(20)
            }
            */
      
        }
    }
        }
    


struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView()
    }
}
