import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var token = ""
    @Published var showAlert = false
    @Published var alertMessage = ""

    func loginUser() {
        let url = URL(string: "http://10.200.100.17/api/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["email": email, "password": password]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Email и пароль не могут быть пустыми"
            showAlert = true
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
        let response = response as? HTTPURLResponse else {
                print("Error: No data returned from server")
                return
            }
           
            switch response.statusCode {
            case 200:
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(LoginResponse.self, from: data)
                    print("Authorization Successful")
                    print("Token: \(response.token)")
                    DispatchQueue.main.async {
                        self.token = response.token
                        self.isLoggedIn = true
                        saveTokenToUserDefaults(token: response.token)
                    }
                } catch let error {
                    print("Error decoding response: \(error.localizedDescription)")
                }
            case 401:
                print("Error: Unauthorized")
            default:
                print("Error: HTTP response code \(response.statusCode)")
            }
        }
        task.resume()
    }


    func logout() {
        self.isLoggedIn = false
        self.token = ""
        UserDefaults.standard.removeObject(forKey: "token") // удаление токена из UserDefaults
        UserDefaults.standard.set(false, forKey: "isLoggedIn")

    }

}

func saveTokenToUserDefaults(token: String) {
    let defaults = UserDefaults.standard
    defaults.set(token, forKey: "token")
}
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Вход")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("purple"))
            
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Пароль", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 16)
            
       
            Button(action: {
                if viewModel.email.isEmpty || viewModel.password.isEmpty {
                    print("Ошибка: заполните все поля")
                } else {
                    viewModel.loginUser()
                }
            }, label: {
                Text("Войти")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color("purple"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .padding(.top, 32)
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.bottom, UIScreen.main.bounds.height * 0.07) // <- изменение тут
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .onReceive(viewModel.$isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                appState.isLoggedIn = true
            }
        }
    }
}


struct LoginResponse: Codable {
    let user: Userr
    let status: Bool
    let token: String
    let token_type: String
    let token_validity: Int
}

struct Userr: Codable {
    let id: Int
    let email: String
    let name: String
    let access_availability: [Int]
    let workPosition: String?
    let active: Int
    let unFollowClients: [Int]
    let favoriteClients: [Int]
    let subscribesRegion: [Int]
}
