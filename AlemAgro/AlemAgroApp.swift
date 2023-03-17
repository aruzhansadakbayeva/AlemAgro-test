//
//  MovieBookingApp.swift
//  MovieBooking
//
//  Created by Willie Yam on 2022-08-16.
//
import Foundation
import SwiftUI
class AppState: ObservableObject {
    @Published var selectedTab = 0
    
    @Published var isLoggedIn: Bool = false {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    @Published var token = "" {
        didSet {
            UserDefaults.standard.set(token, forKey: "token")
        }
    }

    init() {
        loadIsLoggedInFromUserDefaults()
        loadTokenFromUserDefaults()
    }

    private func loadIsLoggedInFromUserDefaults() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    private func loadTokenFromUserDefaults() {
        token = UserDefaults.standard.string(forKey: "token") ?? ""
    }
}


@main
struct AlemAgroApp: App {

    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var appState = AppState()
    var body: some Scene {
        WindowGroup {
            
            if appState.isLoggedIn {
                NavigationView {
                    VStack(spacing: 0) {
                        TabView(selection: $appState.selectedTab) {
                            
                            HomeView()
                              
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("Главная")
                                }
                                .tag(0)
                            
                            ContentView()
                                .tabItem {
                                    Image(systemName: "folder.fill")
                                    Text("Проекты")
                                }
                                .tag(1)
                            
                            ContentView()
                                .tabItem {
                                    Image(systemName: "person.fill")
                                    Text("Профиль")
                                }
                                .tag(2)
                            
                        }
                    }
                 
        
                    
            
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("\(getTitle(for: appState.selectedTab))")
                                .foregroundColor(Color.white).fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                loginViewModel.logout()
                                appState.isLoggedIn = false
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                            }
                            .foregroundColor(Color.white)
                        }
                    }
                    .navigationBarTitle("", displayMode: .inline)

             


                         .toolbarBackground(Color("purple"), for: .navigationBar)
                         .toolbarBackground(.visible, for: .navigationBar)
                    
                 
                       
                        /* .navigationTitle(getTitle(for: appState.selectedTab))
                         .navigationBarTitleDisplayMode(.inline)
                         .foregroundColor(.white)
                         */
                   
                         
                  }
                
                        
                  .environmentObject(appState)
             
            
            } else {
                LoginView()
                    .environmentObject(loginViewModel)
                    .environmentObject(appState)
            }
        }
        
    }
    
    func getTitle(for tab: Int) -> String {
        switch tab {
        case 0:
            return "Главная"
        case 1:
            return "Проекты"
        case 2:
            return "Профиль"
        default:
            return ""
        }
    }

}
