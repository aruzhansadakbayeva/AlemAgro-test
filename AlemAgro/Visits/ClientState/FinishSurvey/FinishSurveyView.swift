//
//  FinishSurveyView.swift
//  AlemAgro
//
//  Created by Aruzhan  on 07.03.2023.
//

import SwiftUI

struct FinishSurveyView: View {
    let data: CombinedData
    @State private var response: String = ""
    @State var buttonPressed = false
    @State var isPressed = false
    @State private var text: String = ""
    var body: some View {
        
            
            
            VStack(spacing: 10){
                Text(response)
                Group{
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Установление/ поддержание контакта"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Установление/ поддержание контакта")
                        
                        
                    }  .buttonStyle(CustomButtonStyle())
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Определение потребностей"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Определение потребностей")
                        
                    } .buttonStyle(CustomButtonStyle())
                    
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Предложение КП"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Предложение КП")
                        
                    } .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Заключение договора"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Заключение договора")
                        
                    } .buttonStyle(CustomButtonStyle())
                    
                    /*    Button(action: {
                     self.buttonPressed.toggle()
                     
                     var key = "main_goal"
                     
                     var newValue = "Осмотр поля"
                     updateAPIValue(key: key, newValue: newValue)
                     }
                     ) {
                     Text("Осмотр поля")
                     
                     } .buttonStyle(CustomButtonStyle())
                     */
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        var key = "main_goal"
                        var newValue =  "Осмотр поля"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {
                    
                        NavigationLink(
                            destination: SurveyView(), label: {
                                Text("Осмотр поля")
                            }
                        )
                        
                    }
                    .buttonStyle(CustomButtonStyle())
                         
                     
                    
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Оплата сбор/долгов"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Оплата сбор/долгов")
                    } .buttonStyle(CustomButtonStyle())
                    
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Работа с документами"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {
                        Text("Работа с документами")
                    } .buttonStyle(CustomButtonStyle())
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "Отработка рекламации"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("Отработка рекламации")
                        
                    } .buttonStyle(CustomButtonStyle())
                    
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "День рождения клиента"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {     Text("День рождения клиента")
                        
                    } .buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        var key = "main_goal"
                        
                        var newValue = "\($text)"
                        updateAPIValue(key: key, newValue: newValue)
                    }
                    ) {      TextField("Другое", text: $text)
                            .multilineTextAlignment(.center)
                          //  .textFieldStyle(.roundedBorder)
                          .padding()
                        
                    } .buttonStyle(CustomButtonStyle())
                }
            }
            
            
        .navigationTitle("\(data.company) **На**: \((data.time).formatted(.dateTime.day().month()))")
                           
        
    }
func updateAPIValue(key: String, newValue: String) {
    
    
    guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(909)") else {
        return
    }
    
    let jsonData = try? JSONSerialization.data(withJSONObject: ["main_goal": newValue])
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Error: invalid HTTP response")
            return
        }
        
        guard let data = data else {
            print("Error: missing response data")
            return
        }
        
        if let responseString = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.response = responseString
            }
        }
    }
    
    task.resume()
}

}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 350, height: 30)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.green.opacity(0.8) : Color.orange)
         
            .cornerRadius(10)
    }
}
