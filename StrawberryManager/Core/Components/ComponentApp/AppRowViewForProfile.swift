//
//  AppRowView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import Kingfisher

struct AppRowViewForProfile: View {
    @ObservedObject var viewModel :  AppRowsViewModel
    @Binding var refeshProfileView : Bool
    @Binding var statusChange : String

    init(appsStatus: AppsStatus,refeshProfile: Binding<Bool>, statusChange : Binding<String>) {
        self.viewModel = AppRowsViewModel(appsStatus: appsStatus)
        _refeshProfileView = refeshProfile
        _statusChange = statusChange
    }
    var body: some View {
        VStack(alignment: .leading) {
            // profile
            if let user = viewModel.appsStatus.user {
                HStack(alignment: .top,spacing: 12){
                    //Circle()
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                    //user info & app caption
                    VStack(alignment: .leading, spacing: 4){
                        HStack {
                            Text("Tien nguyen")
                                .font(.subheadline).bold()
                                .font(.caption)
                            Text("@tien")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text("2W")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        // app caption
                        Text(viewModel.appsStatus.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                }
            }
            HStack(alignment: .top,spacing: 80){
                Button{
                    
                }label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Button{
                    
                }label: {
                    
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Button{
                    viewModel.appsStatus.didLike ?? false ? viewModel.unLikeStatus() : viewModel.likeStatus()
                    if refeshProfileView {
                        statusChange = viewModel.appsStatus.id ?? viewModel.appsStatus.uid
                    }
                }label: {
                    Image(systemName: viewModel.appsStatus.didLike ?? false ? "heart.fill": "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.appsStatus.didLike ?? false ? .red : .gray)
                }
                
                Button{
                    
                }label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding(.horizontal,50)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
        }
        //Divider()
    }
}
