//
//  ContentView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @State private var ismessageTap = false
    @EnvironmentObject var viewModel:  AuthViewModel
    @EnvironmentObject var tabSelection: TabSelection
    var body: some View {
        Group{
            if $viewModel.userSession == nil {
                LoginView()
            } else {
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    
    var mainInterfaceView: some View{
        ZStack(alignment: .topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
                
            if showMenu{
               ZStack{
                   Color(.black)
                       .opacity(showMenu ? 0.25 : 0.0)
               }.onTapGesture {
                   withAnimation(.easeOut){
                       showMenu = false
                   }
               }
               .ignoresSafeArea()
            }
            SideMenuView()
                .frame(width: 300)
                .offset(x : showMenu ? 0 : -300, y : 0)
                .background(showMenu ? .white : .clear)
        }
        .navigationBarHidden(showMenu)
        .navigationTitle(tabSelection.selectedIndex == 0 ? "Home" : (tabSelection.selectedIndex == 1 ? "Explore" : (tabSelection.selectedIndex == 2 ? "Notification" : "Messages")))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                if let user = viewModel.currentUser {
                    Button{
                        withAnimation(.easeInOut){
                            showMenu.toggle()
                          }
                    }label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32,height: 32)
                            .clipShape(Circle())
                    }
                }
                    
            }
        }
        .onAppear{
            showMenu = false
        }
        .onReceive(tabSelection.$selectedIndex) {_ in
            if tabSelection.selectedIndex == 4 {
                ismessageTap = true
            }
        }
        .fullScreenCover(isPresented: $ismessageTap, content: {
            GroupChatView()
        })
        
    }
}
