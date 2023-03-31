//
//  Recommendations.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.03.2023.
//

import SwiftUI
import Speech
import AVFoundation


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
        let urlString = "http://10.200.100.17/api/manager/workspace"
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

    @StateObject var viewModel = PostmanViewModel4()
    @State var selectedItems = Set<PostmanResponse4>()
    @State var showCustomOption = false
    @State var customOptionText = ""
    let optionsDict: [Int: [String]] = [
        1: ["Да", "Другое"],
        2: ["Продажа на этом визите", "Продажа была ранее", "Продажи не было"],
        3: ["Да", "Другое"],
        4: ["Да", "Другое"]
    ]
    
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
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
                        set: {
                            SelectedItemsManager.selectedOptions[item] = $0
                            if $0 == "Другое" {
                                showCustomOption = true
                                
                            } else {
                                showCustomOption = false
                            }
                        }
                    ),
                           label: Text("")) {
                        ForEach(optionsDict[item.id] ?? [], id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                   
                        if showCustomOption && SelectedItemsManager.selectedOptions[item] == "Другое" {
                            HStack {
                                TextField("Введите свой ответ", text: Binding(
                                    get: {  SelectedItemsManager.selectedOptions[item] ?? "" },
                                    set: {  SelectedItemsManager.selectedOptions[item] = $0 }
                                ))
                                .padding()
                                
                       
                            }
                            
                        
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
                    .foregroundColor(isRecording ? .red : .white)
                    .padding()
                    .background(isRecording ? Color.white : Color.blue)
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
                        .background(Color.white)
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
            } catch let error {
                print("Error creating audio player: \(error.localizedDescription)")
            }
        }
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
