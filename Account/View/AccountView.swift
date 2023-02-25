//
//  HomeView.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI
 
struct AccountView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            VStack(alignment: .leading, spacing: 16){
                Text("First Name: \(sessionService.userDetails?.firstName ?? "N/A")")
                Text("Last Name: \(sessionService.userDetails?.lastName ?? "N/A")")
                Text("Occupation: \(sessionService.userDetails?.occupation ?? "N/A")")
            }
            ButtonView(title:"Logout"){
                sessionService.logout()
            }
        }.padding(.horizontal, 16)
            .navigationTitle("Main ContentView")
    }}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
