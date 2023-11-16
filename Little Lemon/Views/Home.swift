//
//  Home.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct Home: View {
//    let persistence = PersistenceController()
    
    var body: some View {
        TabView{
            Menu()
                .tabItem { Label("Menu", systemImage: "list.dash") } 
                .environment(\.managedObjectContext, persistence.container.viewContext) 
            UserProfile()
                .tabItem { Label("Profile", systemImage: "square.and.pencil") }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}

