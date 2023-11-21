//
//  FormField+Helper.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import Foundation
import SwiftUI

/// Returns a Checkbox Label
func CheckmarkFormFieldItem(_ label: String, BoolValue: Binding<Bool>) -> some View {
    Label(label, systemImage: BoolValue.wrappedValue ? "checkmark.square.fill" : "square")
        .onTapGesture {
            BoolValue.wrappedValue.toggle()
        }
        .font(.LLParagraph)
        .padding(1)
}

/// Returns a Section title and one Textfield
func FormFieldItem(Section: String, TextValue: Binding<String>) -> some View{
    // TODO: Font for entered text?
    VStack{
        Text(Section)
            .font(.LLSectionCategories)
            .foregroundStyle(.form)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField(text:TextValue, prompt: Text("Enter \(Section)...") .font(.LLHightlight)) {
        }
        .textFieldStyle(.roundedBorder)
    }
    .padding([.vertical], 2)
}
