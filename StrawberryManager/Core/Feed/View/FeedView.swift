//
//  FeedView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import UIKit

struct FeedView: View {
    @State private var showNewTweetView = false
    @State private var refershFeedView = false
    @State private var statusChange : String = ""
    @ObservedObject var viewModel = FeedViewModel()
    //@State var selectedIndex = 0
    @EnvironmentObject var tabSelection: TabSelection
  
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.apps){ app in
                        AppRowView(appsStatus: app, refeshProfile: $refershFeedView, statusChange: $statusChange)
                            .padding()
                    }
                    .onAppear{
                        // khi upload bai viet se refesh lai view
                        NotificationCenter.default.addObserver(forName: .didUploadStats, object: nil, queue: nil) { _ in
                            viewModel.fetchApps()
                        }
                    }
                }
            }
            .refreshable {
                viewModel.fetchApps()
            }
//            List{
//                ForEach(viewModel.apps){ app in
//                    AppRowView(appsStatus: app, refeshProfile: $refershFeedView, statusChange: $statusChange)
//                        //.padding()
//                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
//                            Button {
//
//                            } label: {
//                                Image(systemName: "trash.fill")
//                            }
//                            .tint(.red)
//                        }
//                }
//                .onAppear{
//                    // khi upload bai viet se refesh lai view
//                    NotificationCenter.default.addObserver(forName: .didUploadStats, object: nil, queue: nil) { _ in
//                        viewModel.fetchApps()
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity,maxHeight: .infinity)
            Button{
                showNewTweetView.toggle()
                tabSelection.selectedIndex = 0
            }label: {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28,height: 28)
                    .padding()
                    .background(.brown)
            }
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView){
                UploadAppView()
            }
        }
        //.navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
extension NSNotification.Name {
    static let didUploadStats = NSNotification.Name("DidUploadStats")
}
