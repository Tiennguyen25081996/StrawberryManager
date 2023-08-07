//
//  UploadAppView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import SwiftUI
import Kingfisher


struct UploadAppView: View {
    @State private var caption = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadAppStatusViewModel()

    var body: some View {
        VStack {
            HStack{
                Button{
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                Spacer()
                
                Button{
                    viewModel.uploadAppStatus(withCaption: caption)
                }label: {
                    Text("Upload")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                }
                .cornerRadius(110)
                
            }.padding()
            HStack(alignment: .top){
                if let user = authViewModel.currentUser {
                    //Circle()
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width:64,height: 64)

                }
                TextArea("Hãy viết gì đó đi !",text: $caption)
            }
            
            .padding()
        }
        .onReceive(viewModel.$didUploadStatus){ success in
            if success {
                presentationMode.wrappedValue.dismiss()
                NotificationCenter.default.post(name: .didUploadStats, object: nil)
            }
        }
    }
}

struct UploadAppView_Previews: PreviewProvider {
    static var previews: some View {
        UploadAppView()
    }
}
