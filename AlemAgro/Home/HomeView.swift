//
//  HomeView.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-17.
//

import SwiftUI


struct HomeView: View {
    @State var animate: Bool = false
    @State private var selection: String? = nil
    
    var backgroundColors: [Color] = [Color("backgroundColor"),Color("purple")]
    var body: some View {
        NavigationView{
            
            ZStack {
                CircleBackground(color: Color("backgroundColor"))
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
                
                
                CircleBackground(color: Color("backgroundColor"))
                    .blur(radius: animate ? 30 : 100)
                    .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
                
                
                VStack(spacing: 0.0) {
                    
                    //    Text("Личный кабинет")
                    /* .fontWeight(.bold)
                     .font(.title3)
                     .foregroundColor(.white)
                     */
                    // CustomSearchBar()
                    //.padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 20.0) {
                            Spacer()
                            MatchedView()
                            
                        }
                        
                        .padding(.bottom, 90)
                        
                    }
                    
                    //.navigationBarTitle("Основные модули")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }     
            /* .background(
             
             LinearGradient(gradient: Gradient(colors: [Color("backgroundColor"), Color("backgroundColor2")]), startPoint: .top, endPoint: .bottom)
             
             
             )
             */
            
            
            
            /* .toolbar {
             ToolbarItem(placement: .principal) {
             
             .foregroundColor(.white)
             
             }
             
             }
             */
            
            
            
        }
     /*   .navigationBarTitleDisplayMode(.inline) .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        Text("Личный кабинет").fontWeight(.bold)
                                            .foregroundColor(Color(.white))
                                    
                                    }
                         
                                }    .toolbarBackground(Color("purple"), for: .navigationBar)
                                .toolbarBackground(.visible, for: .navigationBar)
      */
    }
    
}


