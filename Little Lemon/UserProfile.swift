//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.dismiss) var dismiss
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)!
    let lastName = UserDefaults.standard.string(forKey: kLastName)!
    let email = UserDefaults.standard.string(forKey: kEmail)!
    
    
    var body: some View {
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout"){
                dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
