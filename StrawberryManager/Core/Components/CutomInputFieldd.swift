//
//  CútomInputFiles.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 01/07/2023.
//

import SwiftUI

struct CutomInputField: View {
    let imageName: String
    let placeholderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                
                if isSecureField ?? false {
                    SecureField(placeholderText, text: $text)
                } else {
                    TextField(placeholderText, text: $text)
                }
                
            }
            Divider()
                .background(.gray)
            
        }
    }
}

struct CutomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CutomInputField(imageName: "envelope",
                        placeholderText: "Email",
                        isSecureField: false,
                        text: .constant(""))
    }
}
