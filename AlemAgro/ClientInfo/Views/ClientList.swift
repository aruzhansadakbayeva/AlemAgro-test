//
//  LocationList.swift
//  BCR
//
//  Created by Aruzhan  on 14.12.2022.
//

import SwiftUI

struct ClientList: View {
    var body: some View {
        NavigationView {
           List(clients) { client in
               NavigationLink { ClientDetail(client: client) } label: {
                ClientRow(client: client)
            } }
           // .navigationTitle("Информ")
        }
        
    }
}

struct ClientList_Previews: PreviewProvider {
    static var previews: some View {
        ClientList()
    }
}
