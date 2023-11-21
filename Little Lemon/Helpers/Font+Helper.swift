//
//  Font+Helper.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import Foundation
import SwiftUI

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
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 18)
        let font = Font(newUIFont)
            .weight(.medium)
        return font
    }
    /// Karla - Heavy - 20
    static var LLSectionTitle: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-ExtraBold"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 20)
        let font = Font(newUIFont)
        return font
    }
    /// Karla - Heavy - 16
    static var LLSectionCategories: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-ExtraBold"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 16)
        let font = Font(newUIFont)
        return font
    }
    /// Karla - Bold - 18
    static var LLCardTitle: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
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
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
        let newUIFont = UIFont(descriptor: uiFontDescriptor, size: 16)
        let font = Font(newUIFont)
            .weight(.medium)
        return font
    }
    /// Karla - Bold - 20
    static var LLNavBar: Font {
        let uiFontDescriptor = UIFontDescriptor(fontAttributes: [.name: "Karla-VariableFont_wght"])
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
