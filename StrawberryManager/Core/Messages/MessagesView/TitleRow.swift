//
//  TitleRow.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 09/07/2023.
//

import SwiftUI

struct TitleRow: View {
    var body: some View {
        HStack(spacing: 20){
//            KFImage(URL(string: ""))
//                .resizable()
//                .frame(width: 48, height: 48)
//                .foregroundColor(.red.opacity(0.4))
//                .background(Color.blue)
//                .clipShape(Circle())
            AsyncImage(url: URL( string: "https://firebasestorage.googleapis.com:443/v0/b/strawberrymanager-2f9ff.appspot.com/o/profile_image%2F96066774-7912-4B25-ADC9-D4F5E10FA020?alt=media&token=6875ad00-865f-4b49-80f8-5c50927785d9")){ image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .foregroundColor(Color.red.opacity(0.2))
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading){
                Text("Tiến nguyễn").bold()
                Text("Online").font(.caption).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "phone.fill")
                .foregroundColor(.gray)
                .padding(10)
                .background(.white)
                .cornerRadius(50)
            
            
        }.padding()
            
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow().background(Color.blue.opacity(0.25))
    }
}
