//
//  WholeModel.swift
//  AlemAgro
//
//  Created by Aruzhan  on 20.03.2023.
//

import Foundation
import SwiftUI

struct ClientObj: Decodable {
    let clientId: Int
    let clientName: String
    let address: String
    let clientIin: Int
    let startVisit: String
    let finishVisit: String
    let statusVisit: Bool
    let visitTypeId: Int
    let meetingTypeId: Int
    let meetingCoordinate: String?
    let plotId: Int
    let duration: Double?
    let distance: Double?
}

struct ContractComplication: Decodable {
    let id: String
    let name: String
}

struct WorkDone: Decodable {
    let id: String
    let name: String
}

struct Recomend: Decodable {
    let id: String
    let name: String
    let description: String
}

struct FieldsInsp: Decodable {
    let id: String
    let name: String
    let category: String
    let description: String
}

struct ContractConclusionView: View {
    let clientObj: ClientObj
    let contractComplication: ContractComplication
    let workDone: WorkDone
    let recomend: Recomend
    let fieldsInsp: [FieldsInsp]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Клиент: \(clientObj.clientName)")
            Text("Адрес: \(clientObj.address)")
            Text("ИИН: \(clientObj.clientIin)")
            Text("Сложность заключения договора: \(contractComplication.name)")
            
            
          /*  Text("Начало визита: \(clientObj.startVisit)")
            Text("Конец визита: \(clientObj.finishVisit)")
            Text("Статус визита: \(clientObj.statusVisit ? "Завершен" : "Не завершен")")
            Text("ID типа визита: \(clientObj.visitTypeId)")
            Text("ID типа встречи: \(clientObj.meetingTypeId)")
            if let coordinate = clientObj.meetingCoordinate {
                Text("Координаты встречи: \(coordinate)")
            }
            Text("ID участка: \(clientObj.plotId)")
            if let duration = clientObj.duration {
                Text("Продолжительность визита: \(duration)")
            }
            if let distance = clientObj.distance {
                Text("Расстояние до клиента: \(distance)")
            }
           */
           
            /*
            Text("Выполненная работа: \(workDone.name)")
            Text("Рекомендации: \(recomend.name) - \(recomend.description)")
            Text("Проверяемые поля:")
            ForEach(fieldsInsp, id: \.id) { field in
                VStack(alignment: .leading) {
                    Text("Название поля: \(field.name)")
                    Text("Категория поля: \(field.category)")
                    Text("Описание поля: \(field.description)")
                }
            }
             */
        }
        .padding()
    }
}
