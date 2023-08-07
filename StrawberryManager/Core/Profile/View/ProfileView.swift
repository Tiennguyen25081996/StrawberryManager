//
//  ProfileView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 28/06/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    //@State var selectedIndex = 0
    @EnvironmentObject var tabSelection: TabSelection
    @State private var selectedFilter: AppFillterViewModel = .tweets
    @State private var statusActionfromProfileView : Bool = true
    @State private var statusChange : String = ""
    @State private var statusChangeProfileTweets : String = ""
    @ObservedObject private var profileViewModel: ProfileViewModel
    @Environment(\.presentationMode) var mode
    @Namespace var animation
    private var currentUser: User
    @State private var isPresentingAlert: Bool = false
    @State private var statusIDDelete: String = ""
    init(user: User) {
        self.profileViewModel = ProfileViewModel(user: user)
        self.currentUser = user
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            actionButtons
            userInfoDetails
            appFilterViewBar
            appView
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
extension ProfileView{
    var headerView: some View{
        VStack{
            ZStack(alignment: .bottomLeading){
                Color(.systemBlue)
                    .ignoresSafeArea()
                VStack {
                    Button{
                        mode.wrappedValue.dismiss()
                        tabSelection.selectedIndex = 0
                    }label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20,height: 16)
                            .foregroundColor(.white)
                            .offset(x: 16, y: -4)
                    }
                    KFImage(URL(string: profileViewModel.user.profileImageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 72,height: 72)
                    
                    .offset(x: 16,y:24)
                }
                
            }
            .frame(height: 120)
        }
    }
    var actionButtons: some View{
        HStack(spacing: 12){
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            
            Button {
                
            }label: {
                Text(profileViewModel.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120,height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75))
            }
        }
        .padding(.trailing)
    }
    var userInfoDetails: some View{
        VStack(alignment: .leading, spacing: 4){
            HStack {
                Text(profileViewModel.user.fullname)
                    .font(.title2).bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
            }
            
            Text("@\(profileViewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Your moms favorite villain")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing: 24){
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                    Text("Gotham, NY")
                }
                
                HStack{
                    Image(systemName: "link")
                    Text("www.thejoker.com")
                }
            }.font(.caption)
                .foregroundColor(.gray)
            
            UserStatusView()
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
    var appFilterViewBar: some View{
        HStack{
            ForEach(AppFillterViewModel.allCases, id:\.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(.blue)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule()
                            .foregroundColor(.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
                
            }
        }
        .overlay(Divider().offset(x: 0 ,y : 16))
    }
    var appView: some View{
        VStack{
            if self.selectedFilter == .tweets {
                List{
                    Section{
                        ForEach(profileViewModel.appsStatus(forFilter: self.selectedFilter)){ app in
                            AppRowViewForProfile(appsStatus: app, refeshProfile: $statusActionfromProfileView,statusChange: $statusChangeProfileTweets)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        isPresentingAlert.toggle()
                                        statusIDDelete = app.id ?? ""
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.red)
                                }
                                .padding()
                        }
                        //.listRowSeparator(.hidden)
                    }
                }
                .confirmationDialog("",isPresented: $isPresentingAlert){
                    if isPresentingAlert {
                        Button("Delete items?", role: .destructive) {
                            let filteredObjects = profileViewModel.apps.filter{object in
                                return object.id != nil && object.id != statusIDDelete
                            }
                            profileViewModel.apps = filteredObjects
                            profileViewModel.deleteStatus(statusIDDelete)
                            isPresentingAlert = false
                        }
                    }
                } message: {
                   Text("Status này sẽ bị xoá")
                }
                .listStyle(.inset)
                .environment(\.defaultMinListRowHeight,0)
                .onAppear{
                    profileViewModel.fetchUserApps()
                }
            } else {
                ScrollView{
                    LazyVStack{
                        ForEach(profileViewModel.appsStatus(forFilter: self.selectedFilter)){ app in
                            AppRowView(appsStatus: app, refeshProfile: $statusActionfromProfileView,statusChange: $statusChange)
                                .padding()
                        }
                    }
                }
                .onAppear{
                    profileViewModel.clearData()
                }
                .onChange(of: statusChange){ snapshot in
                    let filteredObjects = profileViewModel.likesStatus.filter{object in
                        return object.id != nil && object.id != snapshot
                    }
                    profileViewModel.likesStatus = filteredObjects
                }
            }
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(username: "Batman",
                               fullname: "Bruce wayne",
                               profileImageUrl: "",
                               email: "batman@gmail.com"))
    }
}
