//
//  UserRowView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 29/06/2023.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12){
            //Circle()
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .clipShape(Circle())
                .scaledToFit()
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 4){
                Text(user.username)
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical,4)
    }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
