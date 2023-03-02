//
//  VisitsView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.02.2023.
//

import SwiftUI

struct VisitsView: View {
    @StateObject private var vm = UsersViewModel()

    var body: some View {
        NavigationView{
            ZStack{
                if vm.isRefreshing {
                    ProgressView()
                }
                
                else{
                    List{
                        ForEach(vm.users, id: \.id){
                            
                             user in
                            UserView(user: user).scaleEffect(x: 1, y: -1, anchor: .center)
                                .listRowSeparator(.hidden)
                        
                        }
                        
                       
                        
                    }.scaleEffect(x: 1, y: -1, anchor: .center)

.listStyle(.plain)
              
                }
            }
            
            .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error){
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
            }
        }
            
    }
}


