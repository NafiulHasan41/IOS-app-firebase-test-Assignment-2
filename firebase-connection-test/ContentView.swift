//
//  ContentView.swift
//  firebase-connection-test
//
//  Created by Nafiul Hasan on 21/11/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @State private var isLoginViewActive = true

    var body: some View {
        NavigationView {
            VStack {
                if isLoginViewActive {
                    LoginView(isLoginViewActive: $isLoginViewActive)
                } else {
                    RegistrationView(isLoginViewActive: $isLoginViewActive)
                }
            }
        }
    }
}

struct LoginView: View {
    @Binding var isLoginViewActive: Bool
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Login") {
                loginUser (email: email, password: password)
            }
            .padding()
            Button("Switch to Registration") {
                isLoginViewActive.toggle()
            }
        }
    }

    func loginUser (email: String, password: String) {
        
       Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
            } else {
              print("User  logged in successfully")          }
        }
  }
}

struct RegistrationView: View {
    @Binding var isLoginViewActive: Bool
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Register") {
                registerUser (name: name, email: email, password: password)
            }
            .padding()
            Button("Switch to Login") {
                isLoginViewActive.toggle()
            }
        }
    }

    func registerUser (name: String, email: String, password: String) {
        Auth.auth().createUser (withEmail: email, password: password) { result, error in
            if let error = error {
               print("Error registering: \(error.localizedDescription)")
            } else {
               print("User  registered successfully")
           }
       }
   }
}

#Preview {
    ContentView()
}
