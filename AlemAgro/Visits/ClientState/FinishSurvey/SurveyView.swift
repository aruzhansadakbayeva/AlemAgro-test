//
//  Survey.swift
//  AlemAgro
//
//  Created by Aruzhan  on 09.03.2023.
//

import SwiftUI

struct SurveyView: View {
    let data: CombinedData
    @State private var response: String = ""
    @State var buttonPressed = false
  //  @State var isPressed = false
    @State private var text: String = ""
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                Text(response)
                var id = data.id
                ScrollView(.horizontal){
                Group{
                    HStack{
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "culture"
                                
                                var newValue = "Зерновые"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("зерновые")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Зерновые").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "culture"
                                
                                var newValue = "Масличные"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("масличные")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Масличные").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "culture"
                                
                                var newValue = "Кукуруза "
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("кукуруза")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Кукуруза").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "culture"
                                
                                var newValue = "Овощи "
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("овощи")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Овощи").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "culture"
                                
                                var newValue = "Другое"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("другое")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Другое").font(.system(size: 14))
                                }
                            }
                        }.padding()
                        }
                        
                    }
                ScrollView(.horizontal){
                Group{
                    HStack{
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "stages"
                                
                                var newValue = "Подготовка посева"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("подготовкапосева")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Подготовка посева").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "stages"
                                
                                var newValue = "Посев"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("посев")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Посев").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "stages"
                                
                                var newValue = "Всходы "
                                updateAPIValue(id: id,key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("всходы")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Всходы").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "stages"
                                
                                var newValue = "Вегетация"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("вегетация")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Вегетация").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "stages"
                                
                                var newValue = "Уборка"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("уборка")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Уборка").font(.system(size: 14))
                                }
                            }
                        }.padding()
                    }
                }
                ScrollView(.horizontal){
                    Group{
                        HStack{
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Сорность"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("сорность")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Сорность").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Вредители"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("вредители")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Вредители").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Болезни"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("болезни")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Болезни").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Качество всходов"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("квсходов")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Качество всходов").font(.system(size: 14))
                                }
                            }
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Другое"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    Image("другое2")
                                        .resizable()
                                        .frame(width: 50, height: 50) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Другое").font(.system(size: 14))
                                }
                            }
                        }.padding()
                    }
                }
            }
        }
        
        
        
    .navigationTitle("\(data.company) **На**: \((data.time).formatted(.dateTime.day().month()))")
                       
    
}
    func updateAPIValue(id: Int, key: String, newValue: String) {


guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
    return
}
   
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["culture": newValue])

    
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
    
    func updateAPIValue2(id: Int, key: String, newValue: String) {


    guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
        return
    }
       
            
            let jsonData = try? JSONSerialization.data(withJSONObject: ["stages": newValue])

        
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
    func updateAPIValue3(id: Int, key: String, newValue: String) {


    guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
        return
    }
       
            
            let jsonData = try? JSONSerialization.data(withJSONObject: ["problem_detection": newValue])

        
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

struct CustButtonStyle: ButtonStyle {
func makeBody(configuration: Configuration) -> some View {
    configuration.label
        .frame(width: 350, height: 30)
        .foregroundColor(.white)
        .background(configuration.isPressed ? Color.green.opacity(0.8) : Color.orange)
     
        .cornerRadius(10)
}
}

    


