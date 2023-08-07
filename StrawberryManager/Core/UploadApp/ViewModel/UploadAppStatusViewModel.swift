//
//  UploadAppStatusViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import Foundation

class UploadAppStatusViewModel: ObservableObject {
    @Published var didUploadStatus = false
    let service = AppService()
   
    func uploadAppStatus(withCaption caption: String){
        service.uploadStatus(caption: caption) { success in
            if success {
                self.didUploadStatus.toggle()
            } else {
                // show error message to user ...
            }
            
        }
    }
}
