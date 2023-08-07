//
//  UserStatusView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import SwiftUI

struct UserStatusView: View {
    var body: some View {
        HStack(spacing: 24){
            HStack(spacing: 4){
                Text("807").bold()
                    .font(.subheadline)
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 4){
                Text("6.9M").bold()
                    .font(.subheadline)
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct UserStatusView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatusView()
    }
}
