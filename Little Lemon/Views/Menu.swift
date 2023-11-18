//
//  Menu.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

@MainActor
struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @State var selectedCategories: Set = [""]
    
    func getMenuData() async {
        
//        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print("Data recieved")
            let decoder = JSONDecoder()
            let menuList = try decoder.decode(MenuList.self, from: data)
            
            
            for item in menuList.menu {
                
                // Checking if object with title exists
                let titles:[String] = viewContext.registeredObjects.map({ NSManagedObject in
                    (NSManagedObject as? Dish)?.title ?? ""
                })
                if titles.contains(item.title) {
                    continue
                }
                    
                let dish = Dish(context: viewContext)
                dish.title = item.title
                dish.image = item.image
                dish.price = item.price
                dish.category = item.category
                dish.summary = item.summary
                dish.id = Int64(item.id)
//                print("Dish category: \(dish.category)")
            }
//            try? viewContext.save()
        } catch{
            print("Error while fetching data: \(error)")
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        // TODO: Finish Category filtering
        if searchText.isEmpty /*&& selectedCategories.isEmpty*/{
            return NSPredicate(value: true)
        }
//        if selectedCategories.contains("Starters"){
//            return NSPredicate(format: "(title CONTAINS[cd] %@) AND (category CONTAINS[cd] %@)", searchText, "Starters")
//        }
 
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
//        return NSPredicate(format: "title MATCHES[cd] %@", searchText) // TODO: Exact match option
    }
    
    var body: some View {
        VStack{

            Hero(searchText: $searchText)
                
            MenuSections(selectedCategories: $selectedCategories)
                .background(.white)
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List{
                    ForEach(dishes){ dish in
                        NavigationLink(destination: MenuItemDetailView(dish: dish)) {
                            HStack{
                                // TODO: Improve layout and add a default image (currently 2 image links are broken)
                                VStack{
                                    Text(dish.title ?? "?")
                                        .font(.LLCardTitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("")
                                    Text(dish.summary ?? "Item served fresh")
                                        .lineLimit(2)
                                        .font(.LLParagraph)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("")
                                    Text("$" + (dish.price ?? "100"))
                                        .font(.LLHightlight)
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
            
        } // End of VStack
        .task{
            await getMenuData()
        }
    }
}

#Preview {
    Menu()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
