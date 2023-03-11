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
    @State private var isClicked = false
    @State private var isClicked2 = false
    @State private var isClicked3 = false
    @State private var isClicked4 = false
    @State private var isClicked5 = false
    @State private var isClicked6 = false
    @State private var isClicked7 = false
    @State private var isClicked8 = false
    @State private var isClicked9 = false
    @State private var isClicked10 = false
    @State private var isClicked11 = false
    @State private var isClicked12 = false
    @State private var isClicked13 = false
    @State private var isClicked14 = false
    @State private var isClicked15 = false
    var body: some View {
        ScrollView{
            VStack(spacing: 10){
                Text(response)
                var id = data.id
                Text("Выберите культуру:").font(.title3)
                ScrollView(.horizontal){
                Group{
                    HStack(spacing: 10){
                      
                            Button(action: {
                                self.buttonPressed.toggle()
                                self.isClicked.toggle()
                                self.isClicked3 = false
                                self.isClicked4 = false
                                self.isClicked5 = false
                                self.isClicked2 = false
                                
                                var key = "culture"
                                
                                var newValue = "Зерновые"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                   isClicked ?
                                    Image("зерновые")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    
                                    :   Image("зерновые")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked2.toggle()
                                var key = "culture"
                                self.isClicked3 = false
                                self.isClicked4 = false
                                self.isClicked5 = false
                                self.isClicked = false
                                var newValue = "Масличные"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked2 ?
                                    Image("масличные")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :        Image("масличные")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked3.toggle()
                                self.isClicked2 = false
                                self.isClicked4 = false
                                self.isClicked5 = false
                                self.isClicked = false
                                var key = "culture"
                                
                                var newValue = "Кукуруза "
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked3 ?
                                    Image("кукуруза")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :      Image("кукуруза")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked4.toggle()
                                self.isClicked3 = false
                                self.isClicked2 = false
                                self.isClicked5 = false
                                self.isClicked = false
                                var key = "culture"
                                
                                var newValue = "Овощи "
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked4 ?
                                    Image("овощи")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    : Image("овощи")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked5.toggle()
                                self.isClicked3 = false
                                self.isClicked4 = false
                                self.isClicked2 = false
                                self.isClicked = false
                                var key = "culture"
                                
                                var newValue = "Другое"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked5 ?
                                    Image("другое")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :      Image("другое")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                Text("Этапы осмотра полей по культуре:").font(.title3)
                ScrollView(.horizontal){
                Group{
                    HStack{
                            Button(action: {
                                self.buttonPressed.toggle()
                                self.isClicked6.toggle()
                                self.isClicked7 = false
                                self.isClicked8 = false
                                self.isClicked9 = false
                                self.isClicked10 = false
                                var key = "stages"
                                
                                var newValue = "Подготовка посева"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                              
                                VStack{
                                    isClicked6 ?
                                    Image("подготовкапосева")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :   Image("подготовкапосева")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    Text("Под-ка посева").font(.system(size: 14))
                                }
                            }
                            
                            
                            Button(action: {
                                self.buttonPressed.toggle()
                                self.isClicked7.toggle()
                                self.isClicked6 = false
                                self.isClicked8 = false
                                self.isClicked9 = false
                                self.isClicked10 = false
                                var key = "stages"
                                
                                var newValue = "Посев"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked7 ?
                                    Image("посев")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :   Image("посев")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked8.toggle()
                                self.isClicked6 = false
                                self.isClicked7 = false
                                self.isClicked9 = false
                                self.isClicked10 = false
                                var key = "stages"
                                
                                var newValue = "Всходы "
                                updateAPIValue(id: id,key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked8 ?
                                    Image("всходы")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :
                                    Image("всходы")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked9.toggle()
                                self.isClicked6 = false
                                self.isClicked7 = false
                                self.isClicked8 = false
                                self.isClicked10 = false
                                var key = "stages"
                                
                                var newValue = "Вегетация"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked9 ?
                                    Image("вегетация")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :   Image("вегетация")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked10.toggle()
                                self.isClicked6 = false
                                self.isClicked7 = false
                                self.isClicked8 = false
                                self.isClicked9 = false
                                var key = "stages"
                                
                                var newValue = "Уборка"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked10 ?
                                    Image("уборка")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :   Image("уборка")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                Text("Обнаружение проблемы:").font(.title3)
                ScrollView(.horizontal){
                    Group{
                        HStack{
                            Button(action: {
                                self.buttonPressed.toggle()
                                self.isClicked11.toggle()
                                
                                var key = "problem_detection"
                                
                                var newValue = "Сорность"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked11 ?
                                    Image("сорность")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :   Image("сорность")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked12.toggle()
                                var key = "problem_detection"
                                
                                var newValue = "Вредители"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked12 ?
                                    Image("вредители")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :                                     Image("вредители")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked13.toggle()
                                var key = "problem_detection"
                                
                                var newValue = "Болезни"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked13 ?
                                    Image("болезни")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :  Image("болезни")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked14.toggle()
                                var key = "problem_detection"
                                
                                var newValue = "Качество всходов"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked14 ?
                                    Image("квсходов")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :                                     Image("квсходов")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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
                                self.isClicked15.toggle()
                                var key = "problem_detection"
                                
                                var newValue = "Другое"
                                updateAPIValue(id: id, key: key, newValue: newValue)
                            }
                            ) {
                                VStack{
                                    isClicked15 ?
                                    Image("другое2")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
                                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                                        .clipShape(Circle()) // Clip the image to a circle shape
                                        .overlay(
                                            Circle().stroke(Color.green, lineWidth: 4) // Add a white stroke around the circle
                                        )
                                        .shadow(radius: 5) // Add a shadow to the button
                                    :                                     Image("другое2")
                                        .resizable()
                                        .frame(width: 110, height: 110) // Set the size of the image
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

    


