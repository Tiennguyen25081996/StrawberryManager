//
//  Users.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 01/07/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct User : Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == id}
}
