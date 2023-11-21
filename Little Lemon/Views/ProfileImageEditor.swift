//
//  EditorProfileView.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import SwiftUI

struct ProfileImageEditor: View {
    @Binding var largeImageName: String
    @Binding var showProfilePicker: Bool
    
    var body: some View {
        
        HStack{
            // Displays a large profile Image from the Asset catelog or a system image from the ProfilePicker.
            LargeProfileIcon(systemImageName: largeImageName)
                .onTapGesture {
                    showProfilePicker = true
                }
            // Presents a custom ProfilePicker view on tap
            Button("Change"){
                showProfilePicker = true
            }
            .buttonStyle(ChangeButtonStyle(padding: 24))
            .sheet(isPresented:$showProfilePicker) {
                ProfileIconPicker(showProfilePicker: $showProfilePicker, largeImageName: $largeImageName)
            }
            .padding()
            
            // "Removes" the Profile Image by replacing it with a "Person" system Image
            Button("Remove"){
                largeImageName = "person.crop.circle"
            }
            .buttonStyle(RemoveButtonStyle(padding: 20))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProfileImageEditor(largeImageName: .constant("profile-image-placeholder"), showProfilePicker: .constant(false))
}
