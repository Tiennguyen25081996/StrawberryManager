//
//  GroupChatModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 12/07/2023.
//

import Foundation

class GroupChatMdodel: ObservableObject{
    private let service = AppService()
    @Published var groupMessageArray = [GroupMessages]()
    init(){
        fetchGroup()
    }
    func fetchGroup() {
        service.fetchGroup{group in
            self.groupMessageArray = group
        }
    }
}
