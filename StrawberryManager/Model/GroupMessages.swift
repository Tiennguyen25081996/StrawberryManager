//
//  GroupMessages.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 12/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct GroupMessages: Identifiable, Decodable {
    @DocumentID var id: String?
    var timestamp: Timestamp
}
