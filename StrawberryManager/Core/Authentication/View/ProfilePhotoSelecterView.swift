//
//  ProfilePhotoSelecterView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 01/07/2023.
//

import SwiftUI

struct ProfilePhotoSelecterView: View {
    @State private var showImagePicker = false
    @State private var selcetedImage : UIImage?
    @State private var profileImage : Image?
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        VStack{
            AuthHeaderView(title1: "Setup account",
                           title2: "Add a profile photo")
            
            Button{
                showImagePicker.toggle()
            } label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .modifier(ProfileImageModifier())
                } else {
                    Image("plus_photo")
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                }
            }
            .sheet(isPresented: $showImagePicker , onDismiss: loadImage){
                ImagePicker(selecterdImage: $selcetedImage)
            }
            .padding(.top,44)
            
            if let selectedImage = selcetedImage {
                Button{
                    viewModel.uploadProfileImage(selectedImage)
                }label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(.blue)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 0)
            }
            
            Spacer()
            
        }.ignoresSafeArea()
    }
    
    func loadImage() {
        guard let selcetedImage = selcetedImage else { return }
        profileImage = Image(uiImage: selcetedImage)
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .scaledToFit()
            .frame(width: 180,height: 180)
            .clipShape(Circle())
    }
}

struct ProfilePhotoSelecterView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelecterView()
    }
}
