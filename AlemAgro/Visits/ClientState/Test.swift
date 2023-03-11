import Foundation
import SwiftUI
struct Post: Codable {
    let id: Int
    var title: String
    var body: String
}

class APIManager {
    func updatePost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post.id)") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let updatedData = try! JSONEncoder().encode(post)
        request.httpBody = updatedData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(false)
                return
            }

            let response = try! JSONSerialization.jsonObject(with: data, options: [])
            print(response)

            completion(true)
        }.resume()
    }
}
struct EditPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var post: Post

    var body: some View {
        VStack {
            TextField("Title", text: $post.title )
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextEditor(text: $post.body)
                .border(Color.gray, width: 1)
            Button("Save") {
                APIManager().updatePost(post: post) { success in
                    if success {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .padding()
    }
}
