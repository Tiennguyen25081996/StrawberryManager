//
//  GroupChatRowView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 12/07/2023.
//

import SwiftUI
import Kingfisher
struct GroupChatRowView: View {
    var body: some View {

           HStack(alignment: .top, spacing: 20){
//               AsyncImage(url: URL( string: "https://firebasestorage.googleapis.com:443/v0/b/strawberrymanager-2f9ff.appspot.com/o/profile_image%2F96066774-7912-4B25-ADC9-D4F5E10FA020?alt=media&token=6875ad00-865f-4b49-80f8-5c50927785d9")){ image in
//                   image.resizable()
//                       .scaledToFill()
//                       .frame(width: 48, height: 48)
//                       .clipShape(Circle())
//                       .foregroundColor(Color.red.opacity(0.2))
//               } placeholder: {
//                   ProgressView()
//               }
               KFImage(URL(string: "https://firebasestorage.googleapis.com:443/v0/b/strawberrymanager-2f9ff.appspot.com/o/profile_image%2F96066774-7912-4B25-ADC9-D4F5E10FA020?alt=media&token=6875ad00-865f-4b49-80f8-5c50927785d9"))
                   .resizable()
                   .scaledToFill()
                   .clipShape(Circle())
                   .frame(width: 48, height: 48)
               VStack(alignment: .leading, spacing: 6){
                   HStack(alignment: .top){
                       Text("Tien Nguyen").font(.headline)
                   }
                   VStack(alignment: .leading){
                       Text("Alooooooooooooooooooooooo....").font(.subheadline)
                           .foregroundColor(.gray)
                           .multilineTextAlignment(.leading)
                   }
               }
           }
    }
}

struct GroupChatRowView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatRowView()
    }
}
