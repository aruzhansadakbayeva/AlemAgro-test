//
//  SingletonManagers.swift
//  AlemAgro
//
//  Created by Aruzhan  on 27.05.2023.
//

import Foundation

class ClientIdManager {
    static let shared = ClientIdManager()
    
    private var currentClientId: Int? = nil
    
    func setCurrentClientId(id: Int) {
        currentClientId = id
    }
    
    func getCurrentClientId() -> Int? {
        return currentClientId
    }
}
class ClientNameManager {
    static let shared = ClientNameManager()
    
    private var currentClientName: String? = nil
    
    func setCurrentClientName(name: String) {
        currentClientName = name
    }
    
    func getCurrentClientName() -> String? {
        return currentClientName
    }
}
class ClientDateVisitManager {
    static let shared = ClientDateVisitManager()
    
    private var ClientDateVisit: String? = nil
    
    func setClientDateVisit(datevisit: String) {
        ClientDateVisit = datevisit
    }
    
    func getClientDateVisit() -> String? {
        return ClientDateVisit
    }
}
class WorkDoneManager {
    static let shared = WorkDoneManager()
    
    private var currentWorkDone: String? = nil
    
    func setWorkDone(name: String) {
        currentWorkDone = name
    }
    
    func getCurrentWorkDone() -> String? {
        return currentWorkDone
    }
}
class ClientVisitTypeNameManager {
    static let shared = ClientVisitTypeNameManager()
    
    private var currentClientVisitTypeName: String? = nil
    
    func setCurrentClientVisitTypeName(name: String) {
        currentClientVisitTypeName = name
    }
    
    func getCurrentClientVisitTypeName() -> String? {
        return currentClientVisitTypeName
    }
}

class VisitIdManager {
    static let shared = VisitIdManager()
    
    private var currentVisitId: Int? = nil
    
    func setCurrentVisitId(id: Int) {
        currentVisitId = id
    }
    
    func getCurrentVisitId() -> Int? {
        return currentVisitId
    }
}

class UserIdManager {
    static let shared = UserIdManager()
    
    private var currentUserId: Int? = nil
    
    func setCurrentUserId(id: Int) {
        currentUserId = id
    }
    
    func getCurrentUserId() -> Int? {
        return currentUserId
    }
}
class TelegramIdManager {
    static let shared = TelegramIdManager()
    
    private var currentTelegramId: String? = nil
    
    func setCurrentTelegramId(id: String) {
        currentTelegramId = id
    }
    
    func getCurrentTelegramId() -> String? {
        return currentTelegramId
    }
}
