//
//  AppFillterViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 29/06/2023.
//

import Foundation

enum AppFillterViewModel: Int, CaseIterable{
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replices"
        case .likes: return "Likes"
        }
    }
}
