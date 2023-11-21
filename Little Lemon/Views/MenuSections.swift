//
//  MenuSections.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/17/23.
//

import SwiftUI


struct MenuSections: View{
    @Binding var selectedCategories: Set<String>

    var body: some View {
        VStack {
            Text("ORDER FOR DELIVERY")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.LLSectionTitle)
            HStack{
                // TODO: Segmented control (Toggle)
                MenuButton(name: "Starters", selectedCategories: $selectedCategories)
                MenuButton(name: "Mains", selectedCategories: $selectedCategories)
                MenuButton(name: "Desserts", selectedCategories: $selectedCategories)
                MenuButton(name: "Drinks", selectedCategories: $selectedCategories)
            }
            .frame(maxWidth: .infinity)
            Divider()
        }

        .padding()
    }
}

#Preview {
    MenuSections(selectedCategories: .constant(["Starters"]))
}
