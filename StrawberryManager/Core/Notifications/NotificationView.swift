//
//  NotificationView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        List{
                ForEach(1...10, id: \.self) { index in
                    Text("Item \(index)")
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .tint(.red)
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
