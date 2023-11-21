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
    
    @State var tabNavigationStyle = true
    @State var selectedTab = 0
    
    var body: some View {
        Group{
            // TabView Navigation
            if tabNavigationStyle {
                TabView(selection: $selectedTab){
                    Menu()
                        .tag(0)
                        .tabItem { Label("Menu", systemImage: "list.dash") }
                    UserProfile(navProfileImage: $navProfileImage, tabNavigationStyle: $tabNavigationStyle)
                        .tag(1)
                        .tabItem { Label("Profile", systemImage: "square.and.pencil") }
                }
            } else {
                // NavigationStack Navigation
                Menu()
                    .navigationDestination(isPresented: $profileTapped){
                        UserProfile(navProfileImage: $navProfileImage, tabNavigationStyle: $tabNavigationStyle)
                    }
                    .onAppear{
                        // TODO: Pop to root (onboarding) screen instead of double dismiss().
                        if !UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                            dismiss()
                        }
                    }
            }
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            // Trailing Profile Image Icon
            ToolbarItem(placement: .topBarTrailing){
                ProfileImageToolbarItem()
            }
            // Centered Logo ToolbarItem
            ToolbarItem(placement: .principal) {
                NavigationLogo()
            }
        }
    }
    
    fileprivate func ProfileImageToolbarItem()  -> some View{
        Group{
            if navProfileImage == "profile-image-placeholder" {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width:40, height: 35, alignment: .leading)
                    .onTapGesture {
                        if tabNavigationStyle {
                            selectedTab = 1
                        } else {
                            profileTapped.toggle()
                        }
                    }
            } else {
                Image(systemName: navProfileImage)
                    .font(.system(size: 25))
                    .onTapGesture {
                        if tabNavigationStyle {
                            selectedTab = 1
                        } else {
                            profileTapped.toggle()
                        }
                    }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        Home()
    }
}
