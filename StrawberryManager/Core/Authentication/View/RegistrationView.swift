//
//  RegistrationView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var fullName = ""
    @Environment(\.presentationMode) var presentationmode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack {
                if viewModel.didAuthenticateUser {
                    NavigationLink {
                        // view next here
                        MainTabView()
                            } label: {
                               ProfilePhotoSelecterView()
                            }
                } else {
               
                    //header view
                    AuthHeaderView(title1: "Get started.", title2: "Create your account")
                        
                    VStack(spacing: 40){
                        CutomInputField(imageName: "envelope", placeholderText: "Email", text: $email)
                        CutomInputField(imageName: "person", placeholderText: "UserName", text: $userName)
                        CutomInputField(imageName: "person", placeholderText: "FullName", text: $fullName)
                        CutomInputField(imageName: "lock", placeholderText: "Password",isSecureField: true, text: $password)
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 44)
                    
                    Button{ action:do {
                        viewModel.register(withEmail: email, userName: userName, fullName: fullName, password: password)
                    }
                    }label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 340, height: 50)
                            .background(.blue)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 0)
                    
                    Spacer()
                    
                    Button {
                        presentationmode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.footnote)
                            
                            Text("Sing In")
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        .padding(.bottom, 32)
                        
                    }
                    .ignoresSafeArea()
                    
                }
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
