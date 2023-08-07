//
//  MainTabView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import Combine


struct MainTabView: View {
    //@State var selectedIndex = 0
    @EnvironmentObject var tabSelection: TabSelection

    var body: some View {
        TabView(selection: $tabSelection.selectedIndex){
            FeedView()
//                .onTapGesture {
//                    tabSelection.selectedIndex = 0
//                }
                .tabItem{
                    Image(systemName: "house")
                }.tag(0)

            ExploreView()
//                .onTapGesture {
//                    tabSelection.selectedIndex = 1
//                }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }.tag(1)

            NotificationView()
//                .onTapGesture {
//                    tabSelection.selectedIndex = 2
//                }
                .tabItem{
                    Image(systemName: "bell")
                }.tag(2)

            MessagesView()
//                .onTapGesture {
//                    tabSelection.selectedIndex = 3
//                }
                .tabItem{
                    Image(systemName: "envelope")
                }.tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

class TabSelection: ObservableObject {
    @Published var selectedIndex = 0
}
