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
                TextField("Search menu", text: $searchText) // TODO: .searchable() alternative?
                    .font(.LLLead) // verify
                    .padding()
                    .background(.highlight1)
                    .clipShape(.buttonBorder)
            }
            .padding()
        }
    }
}

#Preview("Hero") {
    Hero(searchText: .constant(""))
}

// TODO: Verify fonts adhere to style-guide and add custom modifiers (e.g.foreground colors)
public extension Font {
    // Unused at the moment
    static func variableFont(name: String, _ size: CGFloat, axis: [Int: Int] = [:]) -> Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: name, kCTFontVariationAttribute as UIFontDescriptor.AttributeName: axis])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: size)
        return Font(newUIFont)
    }
    /// MarkaziText - Bold - 64
    static var LLTitle: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "MarkaziText-Bold"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 64)
        return Font(newUIFont)
    }
    /// MarkaziText - Regular - 40
    static var LLSubtile: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "MarkaziText-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 40)
        return Font(newUIFont)
    }
    /// Karla - Medium - 18
    static var LLLead: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 18)
        let font = Font(newUIFont)
            .weight(.medium)
        return font
    }
    /// Karla - Heavy - 20
    static var LLSectionTitle: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 20)
        let font = Font(newUIFont)
            .weight(.heavy) // TODO: Extra bold (same as heavy?)
        return font
    }
    /// Karla - Heavy - 16
    static var LLSectionCategories: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 16)
        var font = Font(newUIFont)
            .weight(.heavy) // TODO: Extra bold (same as heavy?)
        return font
    }
    /// Karla - Bold - 18
    static var LLCardTitle: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 18)
        let font = Font(newUIFont)
            .bold()
        return font
    }
    /// Karla - Regular - 16
    static var LLParagraph: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 16)
        return Font(newUIFont)
    }
    /// Karla - Medium - 16
    static var LLHightlight: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 16)
        let font = Font(newUIFont)
            .weight(.medium)
        return font
    }
    /// Karla - Bold - 20
    static var LLNavBar: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-Regular"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 20)
        let font = Font(newUIFont)
            .bold()
        return font
    }
}

public enum FontVariations: Int, CustomStringConvertible {
    public var description: String {
        return "Font vars"
    }
    
    case weight = 2003265652
    case width = 2003072104
    case opticalSize = 1869640570
    case grad = 1196572996
    case slant = 1936486004
    case xtra = 1481921089
    case xopq = 1481592913
    case yopq = 1498370129
    case ytlc = 1498696771
    case ytuc = 1498699075
    case ytas = 1498693971
    case ytde = 1498694725
    case ytfi = 1498695241
}

/// Possible option for animating variable font
//            Text("Little Lemon")
//                .font(.variableFont(name: "MarkaziText-Regular", 64, axis:[FontVariations.weight.rawValue: Int(value)]))
//                .foregroundStyle(.yellow)
//            Slider(value: $value, in: 400...700) { bool in
//                //
//            }
//            Text("\(value)")
