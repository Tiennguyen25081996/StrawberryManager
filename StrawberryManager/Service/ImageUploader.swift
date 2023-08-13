//
//  ImageUploader.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 01/07/2023.
//

import FirebaseStorage
import Firebase
import AVFoundation
import SwiftUI

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completon: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 1) else { return }
        let filename = NSUUID().uuidString

        //let ref = Storage.storage.reference(withpath: "/profile_image/\(filename)")
        let ref = Storage.storage().reference().child("/profile_image/\(filename)")
        ref.putData(imageData, metadata: nil ){_, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error : \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL{imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else {return}
                completon(imageUrl)
            }
            
            
        }
    }
}

