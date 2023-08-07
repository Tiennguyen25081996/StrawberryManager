//
//  ProfileViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 03/07/2023.
//

import Foundation


class ProfileViewModel: ObservableObject {
    @Published var apps = [AppsStatus]()
    @Published var likesStatus = [AppsStatus]()
    private let service = AppService()
    private let userService = UserService()
    let user: User
    
    init(user : User){
        self.user = user
        self.fetchUserApps()
        self.fetchLikedStatusApps()
    }
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Flow"
    }
    func clearData(){
//        self.likesStatus = []
//        self.apps = []
        self.fetchLikedStatusApps()
        self.fetchUserApps()
    }
    func appsStatus(forFilter filter: AppFillterViewModel) -> [AppsStatus]{
        switch filter {
        case.tweets:
            return apps
        case.replies:
            return []
        case.likes:
            return likesStatus
        }
    }
    
    func fetchUserApps(){
        guard let uid = user.id else {return}
        
        service.fetchAppStatus(forUid: uid){ app in
            self.apps = app
            
            for i in 0..<app.count {
                self.apps[i].user = self.user
            }
        }
    }
    
    func fetchLikedStatusApps(){
        guard let uid = user.id else {return}
        service.fetchLidedStatus(forUid: uid){ app in
            self.likesStatus = app
            for i in 0..<app.count {
                let uid = app[i].uid
                self.userService.fetchUser(withUid: uid){ user in
                    self.likesStatus[i].user = user
                }
            }
        }
    }
    func deleteStatus(_ appID: Optional<String>){
        guard let id = appID else {return}
        service.deleteStatus(id){ deleted in
            print("deleted is: \(deleted)")
        }
    }
}
