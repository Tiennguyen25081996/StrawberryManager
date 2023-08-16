//
//  SideMenuViewModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import Foundation

enum SideMenuViewModel: Int,CaseIterable{
    case profile
    case goldChar
    case lits
    case bookmarks
    case logout
    
    var description : String{
        switch self{
        case .profile: return "Profile"
        case .goldChar: return "Bảo Tín Minh Châu"
        case .lits: return "Lists"
        case .bookmarks : return "BookMarks"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self{
        case .profile: return "person"
        case .goldChar: return "chart.xyaxis.line"
        case .lits: return "list.bullet"
        case .bookmarks : return "bookmark"
        case .logout: return "arrow.left.square"
        }
    }
}
