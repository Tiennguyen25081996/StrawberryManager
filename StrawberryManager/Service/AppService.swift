//
//  AppService.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct AppService{
    func uploadStatus(caption: String, copletion: @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data = ["uid" : uid,
                    "caption": caption ,
                    "likes" : 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        
        Firestore.firestore().collection("apps").document()
            .setData(data) {error in
                
                if error != nil {
                    print("DEBUG: Upload Failed")
                    copletion(false)
                    return
                }
                
                copletion(true)
            }
    }
    
    func fetchAppStatus(completion : @escaping([AppsStatus])-> Void){
        Firestore.firestore().collection("apps")
            .order(by: "timestamp", descending: true)
            .getDocuments{ snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let apps = documents.compactMap({try? $0.data(as: AppsStatus.self)})
                completion(apps)
            }
    }
    
    func fetchAppStatus(forUid uid: String, completion: @escaping([AppsStatus])-> Void){
        Firestore.firestore().collection("apps")
            .whereField("uid", isEqualTo: uid)
            .getDocuments{ snapshot, _ in
                guard let documents = snapshot?.documents else {return}
                let apps = documents.compactMap({try? $0.data(as: AppsStatus.self)})
                completion(apps.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()}))
            }
    }
    func fetchAppStatusAddListener(completion : @escaping([AppsStatus])-> Void){
        Firestore.firestore().collection("apps")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener{ QuerySnapshot, error in
                guard let documents = QuerySnapshot?.documents else {return}
                let apps = documents.compactMap({try? $0.data(as: AppsStatus.self)})
                completion(apps)
            }
    }
}
// likes
extension AppService {
    func userJoinGroupChat(_ groupID: String, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        //get group for join
        let curentUser = Firestore.firestore().collection("users").document(uid)
        
        curentUser.getDocument{ (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot else {
                print("Document does not exist")
                return
            }

            if document.exists {
                // Access the fields within the document
                _ = document.data()
                let userJoinGroupChat = Firestore.firestore().collection("users").document(uid).collection("users-GroupChat")
                userJoinGroupChat.document(groupID).setData([:]){ _ in
                    completion()
                }
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    func likeStatusApp(_ apps: AppsStatus, completion: @escaping() -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let appsID = apps.id else {return}
        //get app.likes curent in db
        let curentlikes = Firestore.firestore().collection("apps").document(appsID)
        
        curentlikes.getDocument{ (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot else {
                print("Document does not exist")
                return
            }

            if document.exists {
                // Access the fields within the document
                let data = document.data()
                if let like = data?["likes"] as? Int {
                    let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("users-likes")
                    Firestore.firestore().collection("apps").document(appsID)
                        .updateData(["likes" : like + 1]){_ in
                            userLikeRef.document(appsID).setData([:]){ _ in
                                completion()
                            }
                        }
                }
            } else {
                print("Document does not exist")
            }
        }
        
    }
    func unlikeStatusApp(_ apps: AppsStatus, completion: @escaping()->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let appsID = apps.id else {return}
        
        //get app.likes curent in db
        let curentlikes = Firestore.firestore().collection("apps").document(appsID)
        
        let userLikeRef = Firestore.firestore().collection("users")
            .document(uid)
            .collection("users-likes")
        curentlikes.getDocument{ (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }

            guard let document = documentSnapshot else {
                print("Document does not exist")
                return
            }

            if document.exists {
                // Access the fields within the document
                let data = document.data()
                if let like = data?["likes"] as? Int {
                    Firestore.firestore().collection("apps").document(appsID)
                        .updateData(["likes" : like - 1 ]){_ in
                            userLikeRef.document(appsID).delete{_ in
                                completion()
                            }
                            
                        }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    func checkUserLikeStatusApp(_ apps: AppsStatus, completion: @escaping(Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let appsID = apps.id else {return}
        
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("users-likes")
            .document(appsID).getDocument{ snapshot ,_ in
                guard let snapshot = snapshot else {return}
                completion(snapshot.exists)
            }
    }
    func fetchLidedStatus(forUid uid: String, completion: @escaping([AppsStatus])-> Void){
        //guard let currentuid = Auth.auth().currentUser?.uid else {return}
        var appStatus = [AppsStatus]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("users-likes")
            .getDocuments { snapshot,_ in
                guard let doc = snapshot?.documents else {return}
                doc.forEach{ d in
                    let statusID = d.documentID
                    
                    Firestore.firestore().collection("apps")
                        .document(statusID)
                        .getDocument { snapshot, _ in
                            guard let status = try? snapshot?.data(as: AppsStatus.self) else {return}
                            appStatus.append(status)
                            completion(appStatus)
                        }
                }
                
            }
    }
}
// tweets
extension AppService {
    func deleteUserlikesStatusByID(_ uid: String,_ id : String){
        Firestore.firestore().collection("users")
             .document(uid)
             .collection("users-likes").document(id).delete()
    }
    func deleteStatus(_ appID : Optional<String>, completion: @escaping(Bool)-> Void){
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        guard let appsID = appID else {return}
        // delete users-likes from User
        Firestore.firestore().collection("users").getDocuments{snapshot, _ in
            guard let document = snapshot?.documents else {
                print("Document does not exist")
                return
            }
            document.forEach{doc in
               let userLikeRef = Firestore.firestore().collection("users")
                    .document(doc.documentID)
                    .collection("users-likes")
                userLikeRef.getDocuments{(snapshot, error) in
                    if error != nil {
                        return
                    } else {
                        guard let documents = snapshot?.documents else { return }
                        for i in documents {
                            let existStatusID = i.documentID
                            if existStatusID == appsID {
                                //xoa
                                deleteUserlikesStatusByID(doc.documentID, existStatusID)
                            }
                        }
                    }
                }
                
            }
        }
        // delete status
        Firestore.firestore().collection("apps").document(appsID).delete(){ error in
            if let err = error {
                print("Error removing document: \(err)")
                completion(false)
            } else {
                print("Document successfully removed!")
                completion(true)
            }
        }
       
    }
}
// messages
extension AppService {
    func fetchMessages(completion: @escaping([Messages])-> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("messages").order(by: "timestamp", descending: false).addSnapshotListener{ querySnapshot, error in
            if error != nil {
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            var mess = documents.compactMap({try? $0.data(as: Messages.self)})
            for i in 0 ..< mess.count {
                if uid == mess[i].uid {
                    mess[i].received = false
                } else {
                    mess[i].received = true
                }
            }
            completion(mess.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue()}))
        }
    }
    
    func addMessages(_ message: Messages, completion: @escaping (Bool) -> Void) {
        guard (Auth.auth().currentUser?.uid) != nil else {
            completion(false)
            return
        }
        
        let data = [
            "text": message.text,
            "received": message.received,
            "timestamp": Timestamp(date: Date()),
            "uid": message.uid,
            "groupid": message.groupid
        ] as [String: Any]
        Firestore.firestore().collection("messages").document().setData(data) { error in
            if error != nil {
                print("DEBUG: Upload Failed")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
}
// group
extension AppService {
    func addGroup(_ group: GroupMessages,_ toID: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let data = [
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        let groupRef = Firestore.firestore().collection("group").document()
        let groupID = groupRef.documentID
        
        groupRef.setData(data) { error in
            if let error = error {
                print("Error adding group: \(error)")
                completion(false)
                return
            }
            
            let userJoinRef = Firestore.firestore().collection("group").document(groupID).collection("member")
            userJoinRef.document(uid).setData([:]) { _ in}
            userJoinRef.document(toID).setData([:]) { _ in}
            completion(true)
        }
    }
    func fetchGroup(completion : @escaping([GroupMessages])-> Void){
        guard (Auth.auth().currentUser?.uid) != nil else {return}
        Firestore.firestore().collection("group").order(by: "timestamp", descending: false).addSnapshotListener{ querySnapshot, error in
            if error != nil {
                return
            }
            guard let documents = querySnapshot?.documents else {return}
            let group = documents.compactMap({try? $0.data(as: GroupMessages.self)})
            completion(group)
        }
    }
}
