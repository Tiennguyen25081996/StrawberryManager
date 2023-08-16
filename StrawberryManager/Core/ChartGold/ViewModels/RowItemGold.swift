//
//  RowItemGold.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 15/08/2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct APIResponse: Codable {
    let DataList: DataList
    enum CodingKeys: String, CodingKey {
        case DataList = "DataList"
    }
}

struct DataList: Codable {
    let Data: [RowItemGold]
    enum CodingKeys: String, CodingKey {
        case Data = "Data"
    }
}
struct RowItemGold : Codable {
    let row: String?
    let date: String
    let goldValue: String
    let goldType: String
    let name: String
    let buyPrice: String
    let sellPrice: String
    let transferPrice: String
   
       
//    private enum CodingKeys: String, CodingKey {
//        case date = "@d_1"
//        case goldValue = "@h_1"
//        case goldType = "@k_1"
//        case name = "@n_1"
//        case buyPrice = "@pb_1"
//        case sellPrice = "@ps_1"
//        case transferPrice = "@pt_1"
//        case row
//    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
            
            var dynamicKeys: [DynamicCodingKeys] = []
            
            // Collect all dynamic keys present in the JSON
            for key in container.allKeys {
                if let dynamicKey = DynamicCodingKeys(stringValue: key.stringValue) {
                    dynamicKeys.append(dynamicKey)
                }
            }
            
            date = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@d_") }!)
            goldValue = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@h_") }!)
            goldType = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@k_") }!)
            name = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@n_") }!)
            buyPrice = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@pb_") }!)
            sellPrice = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@ps_") }!)
            transferPrice = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue.starts(with: "@pt_") }!)
            row = try container.decode(String.self, forKey: dynamicKeys.first { $0.stringValue == "@row" }!)
        }
}
// Dynamic Coding Keys to handle variable keys in JSON
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}
