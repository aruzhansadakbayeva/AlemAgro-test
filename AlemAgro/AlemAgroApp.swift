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
                    }    .navigationBarItems(trailing:
                                                Button("Выйти") {
                                                    loginViewModel.logout()
                                                    appState.isLoggedIn = false
                                                }
                                            )
                }
                .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(loginViewModel)
                    .environmentObject(appState)
            }
        }
    }

}
