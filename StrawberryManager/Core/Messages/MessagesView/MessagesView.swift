//
//  MessagesView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import Firebase

struct MessagesView: View {
    @ObservedObject private var messageModel = MessagesModel()
    @ObservedObject private var groupModel = GroupChatMdodel()
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var tabSelection: TabSelection
    @State private var isDeleteGroup: Bool = false
    @State private var searchGroup = ""

    var body: some View {
        NavigationView {
            List {
                // first Commit Githubs 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
                // 20230808
                //Section {
                ForEach(groupModel.groupMessageArray, id: \.id) { group in
                        GroupChatRowView()
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    isDeleteGroup.toggle()
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }.onTapGesture {
                                tabSelection.selectedIndex = 4
                            }
                    }
                //}
            }
            .confirmationDialog("are you sure ?", isPresented: $isDeleteGroup){
                if isDeleteGroup {
                    Button("Delete items?", role: .destructive) {
                        isDeleteGroup = false
                    }
                }
            } message: {
                Text("Tin nhắn này sẽ bị xoá")
            }
            .navigationBarItems(leading:
                HStack(alignment: .top, spacing: 20) {
                    TextField("", text: $searchGroup).frame(width: 340, height: 30)
                        .cornerRadius(10)
                        .padding(.horizontal, 8)
                        .padding(.trailing,-10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray.opacity(0.25), lineWidth: 1)
                        )
                        
                NavigationLink(destination: EmptyView()) {
                    Image(systemName: "plus").onTapGesture {
                        messageModel.addGroup(toid : "MFxJjLsO3Wf1W1PPR71RxLb631x1", group: GroupMessages(timestamp: Timestamp()))
                    }
                  }
                }
            )
            .overlay{
//                if isaddnewGroup {
//                    GroupChatView(isaddNewGroup: $isaddnewGroup)
//                }
            }
        }
    }
}
//struct MessagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessagesView()
//    }
//}
