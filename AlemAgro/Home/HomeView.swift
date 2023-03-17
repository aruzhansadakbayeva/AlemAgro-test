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
    
   
    var body: some View {
        NavigationView{
            
            ZStack {
              
                VStack(spacing: 0.0) {

                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 20.0) {
                            Spacer()
                            MatchedView()
                            
                        }
                        
                        .padding(.bottom, 90)
                        
                    }
              
                }
         //       .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }     
      
            
        }
 
    }
    
}


