//
//  SideOptionRowView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import SwiftUI

struct SideOptionRowView: View {
    var sideMenuViewModel: SideMenuViewModel
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: sideMenuViewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            Text(sideMenuViewModel.description)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideOptionRowView(sideMenuViewModel: .profile)
    }
}
