//
//  MenuButton.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/17/23.
//

import SwiftUI

struct MenuButton: View {
    @State var toggled: Bool = false
    @State var name = ""
    
    @Binding var selectedCategories: Set<String>
    
    var body: some View {
        Text(name)
            .font(.LLLead)
            .padding([.vertical], 8)
            .padding([.horizontal], 10)
            .background(toggled ? .primary1 : .primary2)
            .foregroundColor(toggled ? .highlight1 : .highlight2)
            .clipShape(.buttonBorder) // TODO: Define custom shape with border
            .onTapGesture {
                toggled.toggle()
                if toggled {
                    selectedCategories.insert(name)
                } else {
                    selectedCategories.remove(name)
                }
                
            }
    }
    
}

//#Preview {
//    MenuButton(name: "Long button name", selectedCategories: .constant(["d"]) )
//}
