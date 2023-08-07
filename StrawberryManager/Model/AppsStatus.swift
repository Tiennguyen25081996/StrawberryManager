//
//  Apps.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import FirebaseFirestoreSwift
import Firebase

struct AppsStatus: Identifiable,Decodable {
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
