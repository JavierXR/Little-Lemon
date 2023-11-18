//
//  MenuSections.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/17/23.
//

import SwiftUI



struct MenuSections: View, Observable{
    var body: some View {
        
        HStack{
            MenuButton(name: "Starters")
            MenuButton(name: "Mains")
            MenuButton(name: "Desserts")
            MenuButton(name: "Drinks")
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MenuSections()
}
