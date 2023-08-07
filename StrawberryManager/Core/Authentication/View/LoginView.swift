//
//  LoginView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 30/06/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        // parent container
        VStack{
            
            //header view
           AuthHeaderView(title1: "Hello", title2: "Wellcome Back")
            
            VStack(spacing: 40){
                CutomInputField(imageName: "envelope",
                                placeholderText: "Email",
                                text: $email)
                CutomInputField(imageName: "lock",
                                placeholderText: "Password",
                                isSecureField: true,
                                text: $password)
            }
            .padding(.horizontal,32)
            .padding(.top, 44)
            
            HStack{
                Spacer()
                
                NavigationLink {
                    Text("Reset password view ...")
                } label:{
                    Text("Forgot Password")
                        .fontWeight(.semibold)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.top)
                        .padding(.trailing)
                    
                }
            }
            
            Button{
                viewModel.login(withEmail: email, password: password)
            }label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(.blue)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            NavigationLink {
                RegistrationView()
                    .navigationBarHidden(true)
            } label: {
                HStack{
                    Text("Don't have an account?")
                        .font(.footnote)
                    
                    Text("Sing Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 32)
                .foregroundColor(.blue)
                
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
