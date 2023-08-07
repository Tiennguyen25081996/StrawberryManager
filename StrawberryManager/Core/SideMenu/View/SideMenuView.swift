//
//  SideMenuView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 29/06/2023.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
   
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading){
                    //Circle()
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading,spacing: 4){
                        Text(user.fullname)
                            .font(.headline)
                        Text("@\(user.username)")
                            .font(.caption)
                    }
                    
                    UserStatusView()
                        .padding(.vertical)
                    
                }
                .padding(.leading)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue){ viewModel_item in
                    if viewModel_item == .profile {
                        NavigationLink{
                            ProfileView(user: user)
                        }label: {
                            SideOptionRowView(sideMenuViewModel: .profile)
                        }
                    } else if viewModel_item == .logout {
                        Button{
                            authViewModel.singout()
                        }label: {
                            SideOptionRowView(sideMenuViewModel: viewModel_item)
                        }
                    } else {
                        SideOptionRowView(sideMenuViewModel: viewModel_item)
                    }
                    
                }
                .padding(.vertical,4)
                
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
extension NSNotification.Name {
    static let didfetchProfile = NSNotification.Name("didfetchProfile")
}
