import Foundation
import SwiftUI
import WebKit


class AppState: ObservableObject {
    @Published var selectedTab = 0
    @Published var currentUser: Userr?
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
        // загружаем данные пользователя из UserDefaults
        if let savedUser = UserDefaults.standard.object(forKey: "currentUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(Userr.self, from: savedUser) {
                self.currentUser = loadedUser
            }
        }

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
 
    @StateObject var appState = AppState()
    @StateObject var loginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
         
                          
                           TabView(selection: $appState.selectedTab) {
                               HomeView().environmentObject(appState)
                             //  .preferredColorScheme(.dark)
                                   .tabItem {
                                       Image(systemName: "house")
                                       Text("Главная")
                                   }
                                   .tag(0)
                       
                 /*    WebView(url: URL(string: "http://my.alemagro.com/map")!)
             
                                   .tabItem {
                                       Image(systemName: "folder.fill")
                                       Text("Проекты")
                                   }
                                   .tag(1)
                  */
                              
                               ProfileView().environmentObject(loginViewModel).environmentObject(appState)
                                   .tabItem {
                                       Image(systemName: "person.fill")
                                       Text("Профиль")
                                   }
                                   .tag(1)
                               
                           }
                       
                   
                   // .environmentObject(appState)
                
            } else {
                LoginView()
                   // .environmentObject(loginViewModel)
                    .environmentObject(appState)     
            }
        }
    }

}


struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
}

