//
//  AppRowsViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 03/07/2023.
//

import Foundation

class AppRowsViewModel: ObservableObject {
    private let service = AppService()
    @Published var appsStatus : AppsStatus
    
    let userService = UserService()
    
    init(appsStatus : AppsStatus){
        self.appsStatus = appsStatus
        checkIfUserLikeStatus()
    }

    func likeStatus(){
        service.likeStatusApp(appsStatus){
            self.appsStatus.didLike = true
        }
    }
    func unLikeStatus(){
        service.unlikeStatusApp(appsStatus){
            self.appsStatus.didLike = false
        }
    }

    func checkIfUserLikeStatus(){
        service.checkUserLikeStatusApp(appsStatus){ didlike in
            if didlike {
                self.appsStatus.didLike = true
            } else {
                self.appsStatus.didLike = false
            }
        }
    }
}
