//
//  Messages.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 09/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Messages: Identifiable,Decodable {
    @DocumentID var id: String?
    //var id: String?
    var text: String
    var received : Bool
    var timestamp: Timestamp
    
    var uid: String
    var groupid: String
}
