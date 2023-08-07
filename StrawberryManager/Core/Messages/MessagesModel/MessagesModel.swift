//
//  MessagesModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 09/07/2023.
//

import Foundation
import FirebaseAuth

class MessagesModel: ObservableObject {
    private let service = AppService()
    private let userService = UserService()
    @Published var messagesArray = [Messages]()
    @Published var userSession = Auth.auth().currentUser
    @Published var lastmessageID: String = ""
    @Published var groupid: String = ""
    init() {
        self.fetchMessages()
        self.lastmessageID = messagesArray.last?.id ?? ""
    }
    func addMessages(message: Messages) {
        service.addMessages(message){snapshot in
            
        }
    }
    func fetchMessages(){
        service.fetchMessages{ m in
            self.messagesArray = m
            self.lastmessageID = m.last?.id ?? ""
        }
    }
    func addGroup(toid: String,group: GroupMessages){
        service.addGroup(group, toid){_ in }
    }
}
