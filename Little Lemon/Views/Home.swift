//
//  Home.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct Home: View {
    @State var profileTapped = false
    @Environment(\.dismiss) var dismiss
    
    @State var navProfileImage =  UserDefaults.standard.string(forKey: kProfileImage) ?? "profile-image-placeholder"


    var body: some View {
        
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $profileTapped){
                UserProfile(navProfileImage: $navProfileImage)
            }
            .onAppear{                
                // TODO: Pop to root (onboarding) screen instead of double dismiss().
                if !UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){

                    if navProfileImage == "profile-image-placeholder" {
                        Image("profile-image-placeholder")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width:40, height: 35, alignment: .leading)
                            .onTapGesture {
                                profileTapped.toggle()
                            }
                    } else {
                        Image(systemName: navProfileImage)
                            .font(.system(size: 25))
                            .onTapGesture {
                                profileTapped.toggle()
                            }
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 35)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        Home()
    }
}
