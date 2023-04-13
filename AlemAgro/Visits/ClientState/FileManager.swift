//
//  FileManager.swift
//  AlemAgro
//
//  Created by Aruzhan  on 12.04.2023.
//

import SwiftUI
import Foundation
import MobileCoreServices
import UIKit


struct FileItem: Identifiable {
    var id = UUID()
    var name: String
    var fileURL: URL
}
class FileListModel: ObservableObject {
    @Published var files = [FileItem]()
    
    func addFile(_ fileURL: URL) {
        let fileItem = FileItem(name: fileURL.lastPathComponent, fileURL: fileURL)
        files.append(fileItem)
    }
    
    func removeFile(_ indexSet: IndexSet) {
        files.remove(atOffsets: indexSet)
    }
}
/*
struct FileAttachmentView: View {
    @StateObject var fileListModel = FileListModel()
    @State private var showDocumentPicker = false
    
    var body: some View {
        VStack {
            List {
                ForEach(fileListModel.files) { fileItem in
                    HStack {
                        Text(fileItem.name)
                        Spacer()
                        Text("\(fileItem.fileURL.lastPathComponent)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                .onDelete(perform: fileListModel.removeFile)
            }
            Button(action: {
                showDocumentPicker = true
            }) {
                Label("Выбрать файл", systemImage: "doc")
            }
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker(fileURLs: $fileListModel.files)
        }
    }
}
*/

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var fileURLs: [FileItem]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.content"], in: .import)
        documentPicker.allowsMultipleSelection = true
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            for url in urls {
                let fileItem = FileItem(name: url.lastPathComponent, fileURL: url)
                parent.fileURLs.append(fileItem)
                
                // Send file to server
                sendFileToServer(fileItem)
            }
        }
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            // Handle cancellation if needed
        }
        func sendFileToServer(_ fileItem: FileItem) {
            let boundary = "Boundary-\(UUID().uuidString)"
            let fileURL = fileItem.fileURL
            print("Путь: \(fileURL)")
            let parameters = [
                [
                    "key": "file",
                    "src": "\(fileURL.path)",
                    "type": "file"
                ],
                [
                    "key": "type",
                        "value": "uploadFile",
                        "type": "text"
                ]] as [[String: Any]]
            
            var body = ""
            for param in parameters {
                if param["disabled"] != nil { continue }
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                if param["contentType"] != nil {
                    body += "\r\nContent-Type: \(param["contentType"] as! String)"
                }
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    do {
                        let fileData = try Data(contentsOf: URL(fileURLWithPath: paramSrc), options: [])
                        body += "; filename=\"\(paramSrc)\"\r\n"
                        body += "Content-Type: \"content-type header\"\r\n\r\n"
                        body += "--\(boundary)\r\n"
                        body += "Content-Type: application/octet-stream\r\n\r\n"
                        body += String(data: fileData, encoding: .utf8) ?? ""
                        body += "\r\n"
                    } catch {
                        print("Failed to load file data from URL: \(paramSrc)")
                        print(error.localizedDescription)
                    }
                }
            }
            body += "--\(boundary)--\r\n";
            let postData = body.data(using: .utf8)
            
            var request = URLRequest(url: URL(string: "http://10.200.100.17/api/manager/workspace")!,timeoutInterval: Double.infinity)
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
}
