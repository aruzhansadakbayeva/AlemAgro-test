//
//  LoginView.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI

struct LoginView: View {
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    @StateObject private var vm = LoginViewModelImpl(service: LoginServiceImpl())
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16){
                InputTextFieldView(text: $vm.credentials.email,
                                   placeholder: "Email",
                                   keyboardType:.emailAddress,
                                   sfSymbol: "envelope")
                InputPasswordView(password: $vm.credentials.password,
                                  placeholder: "Password",
                                  sfSymbol: "lock")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    showForgotPassword.toggle()
                }, label: {
                    Text("Забыли пароль?")
                }).font(.system(size: 16, weight: .bold))
                    .sheet(isPresented: $showForgotPassword, content: {
                        ForgotPasswordView()
                    })
            }
            
            VStack(spacing: 16) {
                ButtonView(title: "Вход") { vm.login()
                }
               /* ButtonView(title: "Register", background: .clear,
                           foreground: .blue,
                           border: .blue){
                    showRegistration.toggle()
                }*/
                           .sheet(isPresented: $showRegistration, content: {
                               //RegisterView()
                           })
            }
        } .padding(.horizontal, 15)
           // .navigationTitle("Авторизация")
            .alert(isPresented: $vm.hasError, content: {
                if case .failed(let error) = vm.state {
                    return Alert(title: Text("Error"),
                                 message: Text(error.localizedDescription))
                } else {
                    return Alert(title: Text("Error"),
                                 message: Text("Something went wrong"))
                }
            })
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView()
        }
    }
}
