//
//  LocationDetail.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI

struct ClientDetail: View {
    var client: Client
    var body: some View {
        ScrollView {

            VStack(alignment: .leading) {
                Text(client.clientName)
                    .font(.title)

                HStack {
                    Text("ИИН: \(String(client.clientIin))")
                        .font(.subheadline)


                }

                Divider()

 
               // Text("About \(c.name)")
                   // .font(.title2)
                Text(client.clientAddress)
                Text("Сумма: \(String(client.sumClient))")
            }
            .padding()

     
        }
        .navigationTitle(client.clientName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClientDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetail(client: clients[0])
    }
}
