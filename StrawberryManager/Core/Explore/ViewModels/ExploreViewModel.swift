//
//  ExploreViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    @Published var currentUserLogin: User?
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users.filter({ $0.username != currentUserLogin?.username })
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username != currentUserLogin?.username && ($0.username.contains(lowercasedQuery) || $0.fullname.lowercased().contains(lowercasedQuery))
            })
        }
    }
    
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers{ users in
            self.users = users
        }
    }
}
