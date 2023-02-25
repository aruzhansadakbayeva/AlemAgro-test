//
//  LocationRow.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI

struct ClientRow: View {
    var client: Client
    var body: some View {
        HStack {

            Text(client.clientName).font(.title2)
            Spacer()
        }.padding()
    }
}


struct ClientRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ClientRow(client: clients[0])
            ClientRow(client: clients[1])
        } .previewLayout(.fixed(width: 300, height: 70))
       
    }
}
