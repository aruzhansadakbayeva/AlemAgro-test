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
    @State var buttonPressed2 = false
    @State var buttonPressed3 = false
    @State var buttonPressed4 = false
    @State var buttonPressed5 = false
    @State var buttonPressed6 = false
    @State var buttonPressed7 = false
    @State var buttonPressed8 = false
    @State var buttonPressed9 = false
    @State var buttonPressed10 = false
    @State var isPressed = false
    @State private var text: String = ""
    var body: some View {
   
   //     VStack(alignment: .leading, spacing: 20){
                Text(response)
                var id = data.id
            List{
                Group{
                    Button(action: {
                        self.buttonPressed.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Установление/ поддержание контакта"
                        updateAPIValue(id: id,key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            
                            Text("Установление/ поддержание контакта")
                            Spacer()
                            Image(systemName: buttonPressed ? "checkmark.square.fill" : "square")
                        }
                    }
                    
                    
                    
                    Button(action: {
                        self.buttonPressed2.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Определение потребностей"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            
                            Text("Определение потребностей")
                            Spacer()
                            Image(systemName: buttonPressed2 ? "checkmark.square.fill" : "square")
                            
                        }
                        
                    }
                    
                    
                    
                    Button(action: {
                        self.buttonPressed3.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Предложение КП"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("Предложение КП")
                            Spacer()
                            Image(systemName: buttonPressed3 ? "checkmark.square.fill" : "square")
                        }
                    }
                    
                    Button(action: {
                        self.buttonPressed4.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Заключение договора"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("Заключение договора")
                            Spacer()
                            Image(systemName: buttonPressed4 ? "checkmark.square.fill" : "square")
                        }
                    }
                    
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
                   
                 
                    HStack{
                        NavigationLink(
                            destination: SurveyView(data: data)) {
                                Text("Осмотр поля")
                                Spacer()
                              
                            }
                            Button(action: {
                                self.buttonPressed5.toggle()
                                let key = "main_goal"
                                let newValue =  "Осмотр поля"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            )
            
                            {
                              
                                    Image(systemName: buttonPressed5 ? "checkmark.square.fill" : "square")
                                  
                                }
                                
                            }
                            
                            
                    
                    
                    
                    
                    
                    
                    Button(action: {
                        self.buttonPressed6.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Оплата сбор/долгов"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("Оплата сбор/долгов")
                            Spacer()
                            Image(systemName: buttonPressed6 ? "checkmark.square.fill" : "square")
                            
                        }
                    }
                    
                    
                    
                    Button(action: {
                        self.buttonPressed7.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Работа с документами"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("Работа с документами")
                            Spacer()
                            Image(systemName: buttonPressed7 ? "checkmark.square.fill" : "square")
                        }
                    }
                    
                    
                    Button(action: {
                        self.buttonPressed8.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "Отработка рекламации"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("Отработка рекламации")
                            Spacer()
                            Image(systemName: buttonPressed8 ? "checkmark.square.fill" : "square")
                        }
                    }
                    
                    
                    Button(action: {
                        self.buttonPressed9.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "День рождения клиента"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            Text("День рождения клиента")
                            Spacer()
                            Image(systemName: buttonPressed9 ? "checkmark.square.fill" : "square")
                            
                        }
                        
                    }
                    
                    Button(action: {
                        self.buttonPressed10.toggle()
                        
                        let key = "main_goal"
                        
                        let newValue = "\($text)"
                        updateAPIValue(id: id, key: key, newValue: newValue)
                    }
                    ) {
                        HStack{
                            TextField("Другое", text: $text)
                                .multilineTextAlignment(.leading)
                            //  .textFieldStyle(.roundedBorder)
                            
                            Image(systemName: buttonPressed10 ? "checkmark.square.fill" : "square")
                        }
                    }
                }.listStyle(.sidebar)
                    .foregroundColor(Color(.black))
          //  }.padding()
        }
            
            
        .navigationTitle("\(data.company) **На**: \((data.time).formatted(.dateTime.day().month()))")
                           
        
    }
    func updateAPIValue(id: Int, key: String, newValue: String) {
    
    
    guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
        return
    }
    
    let jsonData = try? JSONSerialization.data(withJSONObject: ["main_goal": newValue])
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
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
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.green.opacity(0.8) : Color.orange)
         
            .cornerRadius(2)
    }
}
