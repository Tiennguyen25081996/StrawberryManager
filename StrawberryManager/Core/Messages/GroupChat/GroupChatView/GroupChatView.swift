//
//  GroupChatView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 12/07/2023.
//

import SwiftUI
import Firebase
struct GroupChatView: View {
    @ObservedObject private var messageModel = MessagesModel()
    @ObservedObject var viewModel = AuthViewModel()
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var tabSelection: TabSelection
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading){
                    HStack(alignment: .top){
                        Button{
                            tabSelection.selectedIndex = 3
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.backward").foregroundColor(.blue)
                        }
                        .padding()
                        Spacer()
                    }
                    
                }
                
                TitleRow()
                ScrollViewReader { proxy in
                    ScrollView{
                        LazyVStack {
                            ForEach(messageModel.messagesArray, id: \.id){ mess in
                                MessagesRowView(message: mess)
                                    .id(mess.id)
                            }
                        }
                    }.padding(.top, 30)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft,.topRight])
                    .frame(maxHeight: .infinity)
                    .onChange(of: messageModel.lastmessageID){ id in
                        print(id)
                        withAnimation{
                            proxy.scrollTo(id,anchor: .bottom)
                        }
                    }
                    .onAppear {
                        // Cuộn xuống bottom khi view xuất hiện (load lại)
                        withAnimation(.linear) {
                            proxy.scrollTo(messageModel.lastmessageID, anchor: .bottom)
                        }
                    }
                }
            }.background(Color.blue.opacity(0.25))
            MessageField()
        }
    }
}

struct GroupChatView_Previews: PreviewProvider {
    static var previews: some View {
        GroupChatView()
    }
}
