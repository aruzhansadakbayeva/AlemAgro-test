//
//  Test.swift
//  AlemAgro
//
//  Created by Aruzhan  on 31.03.2023.
//
import SwiftUI
import AVFoundation

struct VoiceRecordingView: View {
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            if isRecording {
                Text("Recording in progress...")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                Text("Tap to start recording")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            
            Button(action: {
                if isRecording {
                    stopRecording()
                } else {
                    startRecording()
                }
            }) {
                Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .font(.system(size: 128))
                    .foregroundColor(isRecording ? .red : .white)
                    .padding(40)
                    .background(isRecording ? Color.white : Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
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
                        .font(.system(size: 64))
                        .foregroundColor(.blue)
                        .padding(20)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
            }
        }
        .padding()


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
