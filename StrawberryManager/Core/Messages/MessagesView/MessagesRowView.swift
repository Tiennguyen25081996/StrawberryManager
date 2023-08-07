//
//  MessagesRowView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 09/07/2023.
//

import SwiftUI
import Firebase

struct MessagesRowView: View {
    var message : Messages
    @State private var showTime = false
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing){
            HStack{
                Text(message.text)
                    .padding()
                    .background(message.received ? Color.gray : Color.blue.opacity(0.5))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            if showTime {
                HStack {
                    Text("\(message.timestamp.dateValue().formatted(.dateTime.hour().minute()))")
                    Text("√√")
                }.foregroundColor(.gray)
                    .font(.caption2)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
        .onTapGesture {
            showTime.toggle()
        }
    }
}

struct MessagesRowView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesRowView(message: Messages(text: "xin chao ban, lai la minh day. minh la Tien Nguyen, rat vui duoc gap ban", received: true, timestamp: Timestamp(), uid: "", groupid: ""))
    }
}
