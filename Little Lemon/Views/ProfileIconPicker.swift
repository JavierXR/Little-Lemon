//
//  ProfilePicker.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/19/23.
//

import SwiftUI

struct ProfileIconPicker: View {
    @Binding var showProfilePicker: Bool
    @Binding var largeImageName: String
    var body: some View {
        LazyVGrid(columns:  [GridItem(.fixed(150)), GridItem(.fixed(150))] ){
            ImageIcon("hare")
            ImageIcon("tortoise")
            ImageIcon("dog")
            ImageIcon("cat")
            ImageIcon("lizard")
            ImageIcon("bird")
            ImageIcon("ant")
            ImageIcon("ladybug")
            ImageIcon("fish")
            Image("profile-image-placeholder")
                .resizable()
                .frame(width:75, height: 75, alignment: .leading)
                .clipShape(Circle()) // remove white background in Dark mode
                .onTapGesture {
                    largeImageName = "profile-image-placeholder"
                    showProfilePicker = false
                }
        }
    }
    
    func ImageIcon(_ name: String) -> some View{
        Image(systemName: name)
            .font(.system(size: 75))
            .onTapGesture {
                largeImageName = name
                showProfilePicker = false
            }
    }
}

#Preview {
    ProfileIconPicker(showProfilePicker: .constant(false), largeImageName: .constant("person-image-placeholder"))
}
