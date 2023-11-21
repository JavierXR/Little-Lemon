//
//  LargeProfileIcon.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import SwiftUI

struct LargeProfileIcon: View {
    var systemImageName: String
    
    var body: some View {
        if systemImageName == "profile-image-placeholder" {
            Image("profile-image-placeholder")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width:75, height: 75, alignment: .leading)
        } else {
            Image(systemName: systemImageName )
                .resizable()
                .scaledToFit()
                .frame(width:75, height: 75, alignment: .leading)
        }
    }
}

#Preview {
    VStack{
        LargeProfileIcon(systemImageName: "profile-image-placeholder")
        LargeProfileIcon(systemImageName: "magnifyingglass")
    }
}
