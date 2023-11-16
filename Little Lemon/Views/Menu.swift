//
//  Menu.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    func getMenuData(){
        
        PersistenceController.shared.clear() // TODO: Use an exists() validator instead
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        
        /*
         TODO: instead of .dataTask, use .data concurrency (await/async):
             -let (data, _) = try await urlSession.data(from: url)
                - use do/catch with proper error handling
         */
        let data = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("Data recieved")
                let decoder = JSONDecoder()
                let decodedData = try? decoder.decode(MenuList.self, from: data)
                
                if let menuList = decodedData {
                    // Is menuList.menu.forEach() a better alternative?
                    for item in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = item.title
                        dish.image = item.image
                        dish.price = item.price
                        dish.category = item.category
                        dish.summary = item.summary
                        dish.id = Int64(item.id)
                    }
                    try? viewContext.save() // TODO: test if this is necessary, especially after adding an exists() validator.
                }
                
            }
        }
        data.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    var body: some View {
        VStack{
            Text("Little Lemon")
            Text("Chicago")
            Text("A Little Lemon App")
            
            TextField("Search menu", text: $searchText) // TODO: .searchable() alternative?
                .padding()
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List{
                    ForEach(dishes){ dish in
                        NavigationLink(destination: MenuItemDetailView(dish: dish)) {
                            HStack{
                                // TODO: Improve layout and add a default image (currently 2 image links are broken)
                                VStack{
                                    Text(dish.title ?? "?")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("$" + (dish.price ?? "100"))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Spacer()
                                AsyncImage(url: URL(string: dish.image ?? "Add default url")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            }
                        }
                        
                    }
                }
                .listStyle(.plain)
            }
            
        }
        .onAppear{
           getMenuData()
        }
    }
}

#Preview {
    Menu()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
