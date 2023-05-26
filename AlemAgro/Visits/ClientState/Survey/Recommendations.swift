//
//  Recommendations.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.03.2023.
//

import SwiftUI
import Speech
import AVFoundation
import MobileCoreServices


struct PostmanResponse4: Decodable, Equatable, Hashable{
    var id: Int
    var name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: PostmanResponse4, rhs: PostmanResponse4) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


class PostmanViewModel4: ObservableObject {
    @Published var response: [PostmanResponse4] = []
    @Published var otherValue: String = ""
    func fetchData() {
        let urlString = "http://localhost:5001/api/meetings"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
                
        let parameters = ["type": "meetingSurvey", "action":"getHandBookMeetingRecommendations"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
                    
            do {
                let decodedResponse = try JSONDecoder().decode([PostmanResponse4].self, from: data)
                DispatchQueue.main.async {
                    self.response = decodedResponse
                }
            } catch let error {
                print("Error decoding response: \(error)")
            }
           // print(String(data: data, encoding: .utf8)!)
        }.resume()
    }
}
struct Recommendations: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel2 = PostmanViewModel2.shared
    var colorPrimary: Color {
        return colorScheme == .dark ? .black : .white
    }
    @StateObject var viewModel = PostmanViewModel4()
    @State var selectedItems = Set<PostmanResponse4>()
    @State private var showCustomOption = false
    @State var customOptionText = ""
    let optionsDict: [Int: [String]] = [
        1: ["Да", "Нет"],
        2: ["Да", "Нет"],
        3: ["Да", "Нет"]
    ]
    @State var selectedOptionForItem2 = ""

    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false

    @State var selectedOption = ""

    var body: some View {

        VStack {
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                VStack {
                    HStack {
                        Text("\(item.name)")
                        
                        Spacer()
                    }
                    if item.id == 4 {
                        
                        TextField("Введите свой ответ", text: Binding(
                            get: {  SelectedItemsManager.selectedOptions[item] ?? "" },
                            set: {  SelectedItemsManager.selectedOptions[item] = $0 }
                        )).padding()
                        
                    }
                    
                    // print("Selected option for item with id \(item.id): \(SelectedItemsManager.selectedOptions[item] ?? "")")
                    
                    Picker(selection: Binding(
                            get: {   SelectedItemsManager.selectedOptions[item] ?? "" },
                            set: {
                                SelectedItemsManager.selectedOptions[item] = $0
                                if item.id == 2 {
                                    if $0 == "Да" {
                                        showCustomOption = true
                                    } else {
                                        showCustomOption = false
                                    }
                                    SelectedItemsManager.additionalOptionsForId2.removeAll()
                                }
                            }
                        ),
                        label: Text("")) {
                            ForEach(optionsDict[item.id] ?? [], id: \.self) { option in
                                Text(option)
                            }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()

                    
           
                    if item.id == 2 && showCustomOption  {
                        VStack{
                            Picker(selection: $selectedOption, label: Text("")) {
                                ForEach(["Продажа на этом визите"], id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .onChange(of: selectedOption) { newValue in
                                SelectedItemsManager.additionalOptionsForId2.append(newValue)
                            }
                            Picker(selection: $selectedOption, label: Text("")) {
                                ForEach(["Продажа была ранее"], id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .onChange(of: selectedOption) { newValue in
                                SelectedItemsManager.additionalOptionsForId2.append(newValue)
                            }
                            Picker(selection: $selectedOption, label: Text("")) {
                                ForEach(["Продажи не было"], id: \.self) { option in
                                    Text(option)
                                }
                            }
                            .onChange(of: selectedOption) { newValue in
                                SelectedItemsManager.additionalOptionsForId2.append(newValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: .infinity, maxHeight: 100)
                    }

              
                    
                

                
                   


                }

            }
            
         //   .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                           NavigationLink(
                               destination:
        {
            if selectedOption == "Продажи не было" {
                           Difficulties2()
                        }
                     else {
                        SelectedItemsView(selectedItemsHistory: viewModel2.selectedItemsHistory)
                    }},
                label: {
                    Text("Далее")
                        .disabled(selectedOption.isEmpty || (selectedItems.contains(where: { $0.id == 2 }) && selectedOption == "" && showCustomOption))

                    /*
                    Text("Завершить")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.green)
                        .cornerRadius(7)
                     */
                })
       
)

            .onAppear {
                viewModel.fetchData()
          
            }
            
     
        }
        HStack {
            if isRecording {
                Text("Идет запись...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            /*else {
             Text("Tap to start recording")
             .font(.headline)
             .foregroundColor(.gray)
             }
             */
            
            Button(action: {
                if isRecording {
                    stopRecording()
                } else {
                    startRecording()
                }
            }) {
                Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(isRecording ? .red : colorPrimary)
                    .padding()
                    .background(isRecording ? colorPrimary : Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            
            
            if let audioPlayer = audioPlayer {
                
                Button(action: {
                    if isPlaying {
                        audioPlayer.stop()
                        isPlaying = false
                    } else {
                        audioPlayer.play()
                        isPlaying = true
                    }
                }) {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.blue)
                        .padding()
                        .background(colorPrimary)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
        }
        .padding()
        
       .background(Color(UIColor.systemBackground)) // устанавливаем цвет фона для темного режима


        
    }
    func startRecording() {
     
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let audioFilename = documentsPath.appendingPathComponent("recording.m4a")
            print("Аудио файл находится по пути: \(audioFilename)")

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: audioFilename), settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
      
        } catch let error {
            print("Error starting recording: \(error.localizedDescription)")
        }
        
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        
        } catch let error {
            print("Error stopping recording: \(error.localizedDescription)")
        }
        
        if let audioRecorder = audioRecorder {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioRecorder.url)
                sendFileToServer()
            } catch let error {
                print("Error creating audio player: \(error.localizedDescription)")
            }
        }
    }
    func sendFileToServer() {
          let currentVisitId = VisitIdManager.shared.getCurrentVisitId() ?? 0
          let fileURL = audioRecorder?.url // Get the URL of the recorded audio file

          // Check if file URL is available
          guard let fileURL = fileURL else {
              print("Error: URL of recorded audio file is not available")
              return
          }
          
          let parameters = [
              [
                  "key": "file",
                  "type": "file"
              ],
              [
                  "key": "type",
                  "value": "uploadFile",
                  "type": "text"
              ],
              [
                "key": "action",
                "value": "recommendations",
                "type": "text"
              ],
              [
                "key": "visitId",
                "value": "\(currentVisitId)",
                "type": "text"
              ]
          ]
          print(parameters)
          let boundary = "Boundary-\(UUID().uuidString)"
          var body = Data()
          
          for param in parameters {
              if param["disabled"] != nil { continue }
              let paramName = param["key"]!
              body.append("--\(boundary)\r\n".data(using: .utf8)!)
              body.append("Content-Disposition: form-data; name=\"\(paramName)\"".data(using: .utf8)!)
              let paramType = param["type"] as! String
              if paramType == "text" {
                  let paramValue = param["value"] as! String
                  body.append("\r\n\r\n\(paramValue)\r\n".data(using: .utf8)!)
              } else {
                  body.append("; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
                  body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                  do {
                      let fileData = try Data(contentsOf: fileURL, options: [])
                      body.append(fileData)
                      body.append("\r\n".data(using: .utf8)!)
                  } catch {
                      print("Failed to load file data from URL: \(fileURL)")
                      print(error.localizedDescription)
                  }
              }
          }
          body.append("--\(boundary)--\r\n".data(using: .utf8)!)
          let postData = body

          var request = URLRequest(url: URL(string: "http://localhost:5001/api/meetings")!, timeoutInterval: Double.infinity)
          request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

          request.httpMethod = "POST"
          request.httpBody = postData

          let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                  print(String(describing: error))
                  return
              }
              print(String(data: data, encoding: .utf8)!)
          }

          task.resume()
      }

      
      

   
      
  }


   
      
  
          

       


            

         
        
    

   
/*

struct Recommendations: View {
    @StateObject var viewModel = PostmanViewModel4()
    @State var selectedItems = Set<PostmanResponse4>()
    @State var selectedOptions: [PostmanResponse4: String] = [:]
    @State var showCustomOption = false
    
    // Словарь опций для каждого элемента списка
    let optionsDict: [Int: [String]] = [
        1: ["Да", "Другое"],
        2: ["Продажа на этом визите", "Продажа была ранее", "Продажи не было"],
        3: ["Да", "Другое"],
        4: ["Да", "Другое"]
    ]

    
    var body: some View {
        VStack {
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                VStack {
                    HStack {
                        Text("\(item.name)")
                        Spacer()
                    }
                    Picker(selection: Binding(
                        get: {   SelectedItemsManager.selectedOptions[item] ?? "" },
                        set: {   SelectedItemsManager.selectedOptions[item] = $0 }
                    ), label: Text("")) {
                        ForEach(optionsDict[item.id] ?? [], id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if  SelectedItemsManager.selectedOptions[item] == "Другое" {
                        TextField("Введите свой ответ", text: Binding(
                            get: { selectedOptions[item] ?? "" },
                            set: {  SelectedItemsManager.selectedOptions[item] = $0 }
                        ))
                        .padding()
                    }
                }
            }
            .navigationBarItems(trailing:
            NavigationLink(
                destination:
                    SelectedItemsView(),
                label: {
                    Text("Завершить").fontWeight(.bold).foregroundColor(Color.white)
                        .foregroundColor(.white)
                        .font(.subheadline).padding(5)
                        .background(Color.green)
                        .cornerRadius(7)
                } )
            .padding()
                                )
            .onAppear {
                viewModel.fetchData()
            }
     
        }
    }
}
*/
/*
let fieldInspection = Array(SelectedItemsManager.selectedItems2).map { item -> [String: Any] in
         let culture = SelectedItemsManager.selectedItems2.filter { $0.categoryId == 1 }.map { item -> [String: Any] in
             return [
                 "cultId": item.categoryId,
                 "id": item.id,
                 "description": item.name
             ]
         }
         let step = SelectedItemsManager.selectedItems2.filter { $0.categoryId == 2 }.map { item -> [String: Any] in
             return [
                 "cultId": item.categoryId,
                 "tid": item.id,
                 "description": item.name
             ]
         }
         let complications = Array(SelectedItemsManager.selectedItems2.filter { $0.categoryId == 3 }).map { item -> [String: Any] in
             return [
                 "cultId": item.categoryId,
                 "id": item.id,
                 "description": item.name
             ]
         }

         return [
          //   "cultId": categoryId,
             "culture": culture,
             "step": step,
             "complications": complications
         ]
     }
*/
/*
let itemsByCategoryId = Dictionary(grouping: SelectedItemsManager.selectedItems2, by: { $0.categoryId })

let culture = SelectedItemsManager.selectedItems2.filter { $0.categoryId == 1 }.map { item -> [String: Any] in
    return [
        "cultId": item.categoryId,
        "id": item.id,
        "description": item.name
    ]
}

let step = SelectedItemsManager.selectedItems2.filter { $0.categoryId == 2 }.map { item -> [String: Any] in
    return [
        "cultId": item.categoryId,
        "tid": item.id,
        "description": item.name
    ]
}

let complications = (itemsByCategoryId[3] ?? []).map { item -> [String: Any] in
    return [        "cultId": item.categoryId,        "id": item.id,        "description": item.name    ]
}

let fieldInspection = [    "culture": culture,    "step": step,    "complications": complications]
*/
struct Recommendations2: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel2 = PostmanViewModel2.shared
    var colorPrimary: Color {
        return colorScheme == .dark ? .black : .white
    }
    @StateObject var viewModel = PostmanViewModel4()
    @State var selectedItems = Set<PostmanResponse4>()
    @State var showCustomOption = false
    @State var customOptionText = ""
    let optionsDict: [Int: [String]] = [
        1: ["Да", "Нет"],
        2: ["Да", "Нет"],
        3: ["Да", "Нет"]
    ]
    @State var selectedOptionForItem2 = ""

    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false

    @State private var selectedOption = ""

    var body: some View {

        VStack {
            List(viewModel.response, id: \.id, selection: $selectedItems) { item in
                VStack {
                    HStack {
                        Text("\(item.name)")
                        
                        Spacer()
                    }
                    if item.id == 4 {
                        
                        TextField("Введите свой ответ", text: Binding(
                            get: {  SelectedItemsManager.selectedOptions[item] ?? "" },
                            set: {  SelectedItemsManager.selectedOptions[item] = $0 }
                        )).padding()
                        
                    }
                    
                    // print("Selected option for item with id \(item.id): \(SelectedItemsManager.selectedOptions[item] ?? "")")
                    
                    Picker(selection: Binding(
                        get: {   SelectedItemsManager.selectedOptions[item] ?? "" },
                        set: {
                            SelectedItemsManager.selectedOptions[item] = $0
                            // SelectedItemsManager.selectedOptions[item] = selectedOption
                            if item.id == 2{
                                if $0 == "Да" {
                                    showCustomOption = true
                                } else {
                                    showCustomOption = false
                                }
                            }
                            // print("Selected option for item with id \(item.id): \($0)")
                        }
                    ),
                           label: Text("")) {
                        ForEach(optionsDict[item.id] ?? [], id: \.self) { option in
                            Text(option)
                        }
                    }
                           .pickerStyle(SegmentedPickerStyle())
                           .frame(maxWidth: .infinity)
                           .padding()
                    
                    
                    if item.id == 2 && showCustomOption && SelectedItemsManager.selectedOptions[item] == "Да" {
                        Picker(selection: $selectedOption, label: Text("")) {
                            ForEach(["Продажа на этом визите", "Продажа была ранее", "Продажи не было"], id: \.self) { option in
                                Text(option).font(.system(size: 16))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .onChange(of: selectedOption) { newValue in
                            // Присваиваем выбранное значение к SelectedItemsManager.selectedOptions[item]
                            SelectedItemsManager.selectedOptions[item] = newValue
                        }
                        // Дополнительный код
                    }
                    
                

                
                   


                }

            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
                           NavigationLink(
                               destination:
        {
            if selectedOption == "Продажи не было" {
                           Difficulties2()
                        }
                     else {
                        SelectedItemsView(selectedItemsHistory: viewModel2.selectedItemsHistory)
                    }},
                label: {
                    Text("Далее")
                        .disabled(selectedOption.isEmpty || (selectedItems.contains(where: { $0.id == 2 }) && selectedOption == "" && showCustomOption))

                    /*
                    Text("Завершить")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .padding(5)
                        .background(Color.green)
                        .cornerRadius(7)
                     */
                })
       
)

            .onAppear {
                viewModel.fetchData()
          
            }
            
     
        }
        HStack {
            if isRecording {
                Text("Идет запись...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            /*else {
             Text("Tap to start recording")
             .font(.headline)
             .foregroundColor(.gray)
             }
             */
            
            Button(action: {
                if isRecording {
                    stopRecording()
                } else {
                    startRecording()
                }
            }) {
                Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(isRecording ? .red : colorPrimary)
                    .padding()
                    .background(isRecording ? colorPrimary : Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            
            
            if let audioPlayer = audioPlayer {
                
                Button(action: {
                    if isPlaying {
                        audioPlayer.stop()
                        isPlaying = false
                    } else {
                        audioPlayer.play()
                        isPlaying = true
                    }
                }) {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.blue)
                        .padding()
                        .background(colorPrimary)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
        }
        .padding()
        
       .background(Color(UIColor.systemBackground)) // устанавливаем цвет фона для темного режима


        
    }
    func startRecording() {
     
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            let audioFilename = documentsPath.appendingPathComponent("recording.m4a")
            print("Аудио файл находится по пути: \(audioFilename)")

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: URL(fileURLWithPath: audioFilename), settings: settings)
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
      
        } catch let error {
            print("Error starting recording: \(error.localizedDescription)")
        }
        
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch let error {
            print("Error stopping recording: \(error.localizedDescription)")
        }
        
        if let audioRecorder = audioRecorder {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioRecorder.url)
                sendFileToServer()
            } catch let error {
                print("Error creating audio player: \(error.localizedDescription)")
            }
        }
    }
    func sendFileToServer() {
        let currentVisitId = VisitIdManager.shared.getCurrentVisitId() ?? 0
        let fileURL = audioRecorder?.url // Get the URL of the recorded audio file

        // Check if file URL is available
        guard let fileURL = fileURL else {
            print("Error: URL of recorded audio file is not available")
            return
        }
        
        let parameters = [
            [
                "key": "file",
                "type": "file"
            ],
            [
                "key": "type",
                "value": "uploadFile",
                "type": "text"
            ],
            [
              "key": "action",
              "value": "recommendations",
              "type": "text"
            ],
            [
              "key": "visitId",
              "value": "\(currentVisitId)",
              "type": "text"
            ]
        ]
        print(parameters)
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        for param in parameters {
            if param["disabled"] != nil { continue }
            let paramName = param["key"]!
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(paramName)\"".data(using: .utf8)!)
            let paramType = param["type"] as! String
            if paramType == "text" {
                let paramValue = param["value"] as! String
                body.append("\r\n\r\n\(paramValue)\r\n".data(using: .utf8)!)
            } else {
                body.append("; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                do {
                    let fileData = try Data(contentsOf: fileURL, options: [])
                    body.append(fileData)
                    body.append("\r\n".data(using: .utf8)!)
                } catch {
                    print("Failed to load file data from URL: \(fileURL)")
                    print(error.localizedDescription)
                }
            }
        }
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        let postData = body

        var request = URLRequest(url: URL(string: "http://10.200.100.17/api/manager/workspace")!, timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }

    
    

 
    
}
