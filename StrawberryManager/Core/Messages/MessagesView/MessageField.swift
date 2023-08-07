//
//  MessageField.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 09/07/2023.
//

import SwiftUI
import Firebase
struct MessageField: View {
    @State private var message = ""
    @ObservedObject private var messagesModel = MessagesModel()
    @FocusState private var textfieldIsFocus : Bool
    @State private var oldValue: String = ""
    @State private var ischangeMessages: Bool = false
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Nhập nội dung ở đây ..."), text: $message)
                .focused($textfieldIsFocus)
                .onChange(of: message){messages in
                    if !messages.isEmpty {
                        ischangeMessages = true
                    } else {
                        ischangeMessages = false
                    }
                }
            Button{
                messagesModel.addMessages(message: Messages(text: message, received: true, timestamp: Timestamp(), uid: Auth.auth().currentUser?.uid ?? "", groupid: "m7aQoQ5EQ516kUsmOFxu"))
                textfieldIsFocus = false
                self.message = ""
            }label: {
                Image(systemName: "paperplane.fill")
                    .clipShape(Circle())
                    .foregroundColor(.white)
                    .padding(15)
                    .background(ischangeMessages ? .blue : .blue.opacity(0.4))
                    .cornerRadius(30)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.gray.opacity(0.25))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
    }
}
struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChange: (Bool) -> () = {_ in}
    var comit: () -> () = {}
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                placeholder.opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChange, onCommit: comit)
        }
    }
}
