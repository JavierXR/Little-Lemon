//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("First Name",text: $firstName)
                TextField("Last Name",text: $lastName)
                TextField("Email",text: $email)
                
                Button("Register") {
                    // TODO: Add email validation (inline?)
                    if (!firstName.isEmpty &&
                        !lastName.isEmpty &&
                        !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    }
                    
                }
            }
            .onAppear{
                if (UserDefaults.standard.bool(forKey: kIsLoggedIn)){
                    isLoggedIn = true
                }
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
        }
        
        
    }
}

#Preview {
    Onboarding()
}
