//
//  FeedViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import Foundation


class FeedViewModel: ObservableObject {
    @Published var apps = [AppsStatus]()
    let service = AppService()
    let userService = UserService()
    
    init() {
        fetchApps()
    }
    func fetchApps(){
        service.fetchAppStatus{ apps in
            self.apps = apps
            
            for i in 0 ..< apps.count {
                let uid = apps[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.apps[i].user = user
                }
            }
        }
    }
}
