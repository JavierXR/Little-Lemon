//
//  MenuItemDetailView.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/16/23.
//

import SwiftUI

struct MenuItemDetailView: View {
    let dish: Dish
    var body: some View {
        // TODO: Add more details and stylize
        VStack{
            Text(dish.title ?? "Default Title")
                .font(.title)
                .bold()
            Text(dish.summary ?? "Default summary")
        }
        .padding()
    }
}

#Preview {
    let dish = Dish(context: PersistenceController.shared.container.viewContext)
    dish.id = 0
    dish.title = "Dish Title"
    dish.category = "starters"
    dish.image = "image url"
    dish.price = "10"
    dish.summary = "Default summary"
    return MenuItemDetailView(dish: dish)
}
