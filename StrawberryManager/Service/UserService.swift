//
//  UserService.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 01/07/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument{ snapshot,_ in
                guard (snapshot?.data()) != nil else {return}
                
                guard let user = try? snapshot?.data(as: User.self) else {return}
                completion(user)
            }
        
    }
    
    func fetchUsers(completion: @escaping([User])-> Void){
        Firestore.firestore().collection("users")
            .getDocuments { snapshot , _ in
                guard let  doc = snapshot?.documents else {return}
                let users = doc.compactMap({ try?$0.data(as: User.self)})
                completion(users)
            }
    }
}
