import SwiftUI
import Combine

struct ClientStView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var filteredData: [CombinedData] = []
    let data: CombinedData
    @State private var response: String = ""
    @State var buttonPressed = false
    @State var isFinished = false
    
    var body: some View {
        

            VStack(alignment: .leading){
                Text("**Компания**: \(data.company)")
                Text("**На**: \((data.time).formatted(.dateTime.day().month()))")
                Text("**Район**: \(data.district)")
                Text("**Потенциал**: \(data.potential) тг")
                Text("**Проникновение АА**: \(data.pa) %")
                Text("**Количество Визитов**: \(data.visitsQty)")
                Text("**Cумма Закл Договоров**: \((data.potential)/100*10) 10% от потенциала")

      
                    VStack {
                        Text(response)
                            .padding()
                 //       ForEach(viewModel.filteredData, id: \.id) { data in
                            var id = data.id
                        Button(action: {
                            self.buttonPressed.toggle()
                           
                            @State var key = "isFlagged"
                            
                            @State var newValue = self.buttonPressed
                            
                            updateAPIValue(id: id, key: key, newValue: newValue)
                            
                            
                            
                        }
                        ) {
                             if !buttonPressed{
                                
                                
                                Text("Начать визит")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                                
                                
                            }
                            
                            if buttonPressed{
                                Button(action: {
                                self.isFinished.toggle()
                                  
                                    @State var key = "isFlagged"
                                    
                                    @State var newValue = false
                                    
                                    
                                    updateAPIValue(id: id, key: key, newValue: newValue)
                                    
                                    // Code to execute when the "Finish" button is pressed
                                    //    isFinished = true
                                    
                                }) {
                                    if !isFinished{
                                        Text("Завершить визит").foregroundColor(Color.white)
                                            .padding()
                                            .background(Color.red)
                                            .cornerRadius(10)
                                    }}
                                if isFinished {
                                    NavigationLink(
                                        destination: SelectVisitView(),
                                        label: {
                                            Text("Продолжить").foregroundColor(Color.white)
                                                .padding()
                                                .background(Color.red)
                                                .cornerRadius(10)
                                        })
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    
              //  }
        
        
        }.padding()
        
        
    }


    
    
    
    
    func updateAPIValue(id: Int, key: String, newValue: Bool) {
        guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
        return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["isFlagged": newValue])
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()


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
    
    func updateAPIValue2(id: Int, key: String, newValue: Bool) {
        guard let url = URL(string: "https://my-json-server.typicode.com/aruzhansadakbayeva/database/posts/\(id)") else {
        return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["isFlagged": newValue])
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let decoder = JSONDecoder()


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
