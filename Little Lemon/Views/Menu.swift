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
    @State var selectedCategories: Set = ["Starters", "Mains", "Desserts", "Drinks"]
    
    func getMenuData() async {
                
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
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
                dish.price = Float(item.price) ?? 0
                dish.category = item.category
                dish.summary = item.summary
                dish.id = Int64(item.id)
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
        if searchText.isEmpty &&
            selectedCategories.contains("Starters") &&
            selectedCategories.contains("Mains") &&
            selectedCategories.contains("Desserts") &&
            selectedCategories.contains("Drinks"){
            return NSPredicate(value: true)
        }
        
        if selectedCategories.isEmpty{
            return NSPredicate(value: false)
        }
        
        var predicateString = ""
        
        let numOfCategories = selectedCategories.count
        var predicatesAdded = 0
        
        if selectedCategories.contains("Starters"){
            if searchText.isEmpty {
                predicateString += String(format: "(category CONTAINS[cd] \"Starters\")", searchText)
            } else {
                predicateString += String(format: "(title CONTAINS[cd] \"%@\" AND category CONTAINS[cd] \"Starters\")", searchText)
            }
            predicatesAdded += 1
            if predicatesAdded < numOfCategories {
                predicateString += " OR "
            }
        }
        if selectedCategories.contains("Mains"){
            if searchText.isEmpty {
                predicateString += String(format: "(category CONTAINS[cd] \"Mains\")", searchText)
            } else {
                predicateString += String(format: "(title CONTAINS[cd] \"%@\" AND category CONTAINS[cd] \"Mains\")", searchText)
            }
            predicatesAdded += 1
            if predicatesAdded < numOfCategories {
                predicateString += " OR "
            }
        }
        if selectedCategories.contains("Desserts"){
            if searchText.isEmpty {
                predicateString += String(format: "(category CONTAINS[cd] \"Desserts\")", searchText)
            } else {
                predicateString += String(format: "(title CONTAINS[cd] \"%@\" AND category CONTAINS[cd] \"Deserts\")", searchText)
            }
            predicatesAdded += 1
            if predicatesAdded < numOfCategories {
                predicateString += " OR "
            }
        }
        if selectedCategories.contains("Drinks"){
            if searchText.isEmpty {
                predicateString += String(format: "(category CONTAINS[cd] \"Drinks\")", searchText)
            } else {
                predicateString += String(format: "(title CONTAINS[cd] \"%@\" AND category CONTAINS[cd] \"Drinks\")", searchText)
            }
            predicatesAdded += 1
            if predicatesAdded < numOfCategories {
                predicateString += " OR "
            }
        }
        
        var predicate: NSPredicate
        predicate = NSPredicate(format: predicateString)
        return predicate
}
    
    var body: some View {
        VStack{

            Hero(searchText: $searchText)
                
            MenuSections(selectedCategories: $selectedCategories)
            
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
                                    
                                    
                                    Text("$" + String(format:"%.0f",dish.price) )
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
    NavigationStack{
        Menu()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
