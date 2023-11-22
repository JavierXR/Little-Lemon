//
//  ButtonStyle+Helper.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let height: CGFloat = 40
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(configuration.isPressed ? .primary1 : .primary2)
            .cornerRadius(16)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    let height: CGFloat = 40
    let padding: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding([.horizontal],padding)
            .frame(minWidth: height, minHeight: height)
            .background(configuration.isPressed ? .primary2 : .primary1)
            .cornerRadius(height/2)
    }
}

struct ChangeButtonStyle: ButtonStyle {
    let height: CGFloat = 40
    let padding: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.LLHightlight)
            .padding([.horizontal],padding)
            .foregroundStyle(configuration.isPressed ? .highlight2 : .highlight1)
            .frame(minWidth: height, minHeight: height * 1.25)
            .background(.primary1)
            .cornerRadius(16)
    }
}

struct RemoveButtonStyle: ButtonStyle {
    let height: CGFloat = 40
    let padding: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.LLHightlight)
            .padding([.horizontal],padding)
            .foregroundStyle(configuration.isPressed ? .highlight2 : .primary1)
            .frame(minWidth: height, minHeight: height * 1.25)
            .background(.highlight1)
            .cornerRadius(16)
    }
}

