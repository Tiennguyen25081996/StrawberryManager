//
//  VIewController.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 02/07/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCallManage()
    }
    func startCallManage(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            let callManage = CallManager()
            let id = UUID()
            print("ID : \(id)")
            //UUID(uuidString: "462594F6-CF39-473A-86B7-1F426FFAFD73")
            callManage.reportIncomingCall(id: id, handle: "Tim Cook")
        })
    }
}
