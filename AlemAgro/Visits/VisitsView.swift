//
//  VisitsView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.02.2023.
//

import SwiftUI
struct VisitsView: View {
    @StateObject private var vm = UsersViewModel()
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView{
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .padding()

                ZStack{
                    if vm.isRefreshing {
                        ProgressView()
                    }

                    else{
                        List{
                            ForEach(filteredUsers(), id: \.id){ user in
                                UserView(user: user)
                                   
                                    .listRowSeparator(.hidden)
                            }
                        }
                        
                        .listStyle(.plain)
                    }
                }
                .padding(.bottom)

            }
            .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError, error: vm.error){
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
            }
            .navigationTitle("Визиты")
        }
    }

    private func filteredUsers() -> [User] {
        return vm.users.filter {
            Calendar.current.isDate($0.time, inSameDayAs: selectedDate)
        }
    }
}
