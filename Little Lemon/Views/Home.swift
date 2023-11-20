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
    
    var body: some View {
        
        // Original excercises asked for TabView navigation, wireframe and screenshot examples have Stack navigation.
        //        TabView{
        //            Menu()
        //                .tabItem { Label("Menu", systemImage: "list.dash") }
        //                .environment(\.managedObjectContext, persistence.container.viewContext)
        //            UserProfile()
        //                .tabItem { Label("Profile", systemImage: "square.and.pencil") }
        //        }
        
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $profileTapped){
                UserProfile()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 35)
                        .clipShape(Circle()) // remove white background in Dark mode
                        .onTapGesture {
                            profileTapped.toggle()
                            print("Image tapped")
                        }
                }
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 35)
                }
            }
            .onAppear{
                // TODO: Pop to root (onboarding) screen instead of double dismiss().
                if !UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    dismiss()
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
