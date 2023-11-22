//
//  Hero.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/16/23.
//

import SwiftUI

struct Header: View {
    
    var body: some View {
        Text("")
    }
}

struct Hero: View {
    @Binding var searchText: String
    var includeTextField = true
    
    var body: some View {
        ZStack{
            Color.primary1
            
            VStack {
                Text("Little Lemon")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.LLTitle)
                    .foregroundStyle(.primary2)
                HStack{
                    VStack{
                        Text("Chicago")
                            .font(.LLSubtile)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.highlight1)
                            .padding([.top],-80) // TODO: Better Layout
                        
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .font(.LLLead)
                            .foregroundStyle(.highlight1)
                            .frame( maxHeight: .infinity,  alignment: .topLeading)
                            .padding([.top],-30) // TODO: Better Layout
                    }
                    Image("Hero image")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 150)
                        .clipShape(.rect(cornerRadii: .init(topLeading: 10,bottomLeading: 10,bottomTrailing: 10,topTrailing: 10)))
                }
                if  includeTextField {
                    TextField("Search menu", text: $searchText ) // TODO: Add Magnifying Icon
                        .font(.LLLead) // verify
                        .padding()
                        .background(.highlight1)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 8)
                }

            } // End VStack
            .padding([.horizontal], 8)
        } // End ZStack
    }
}

#Preview("Hero") {
    Hero(searchText: .constant(""))
}
