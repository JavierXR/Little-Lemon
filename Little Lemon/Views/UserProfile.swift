//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.dismiss) var dismiss
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName)
    let lastName = UserDefaults.standard.string(forKey: kLastName)
    let email = UserDefaults.standard.string(forKey: kEmail)
    
    @State var firstNameF = ""
    @State var lastNameF = ""
    @State var emailF = ""
    
    @State var orderStatus = false
    @State var passwordChanges = false
    @State var specialOffers = false
    @State var newsletter = false
    
    var body: some View {
        VStack{
            Text("Personal Information")
                .font(.LLLead)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width:75, height: 75, alignment: .leading)
                Button("Change"){
                }
                .font(.LLHightlight)
                .padding()
                .foregroundStyle(.highlight1)
                .background(.primary1)
                .clipShape(.buttonBorder)
                
                Button("Remove"){
                }
                .font(.LLHightlight)
                .padding()
                .foregroundStyle(.primary1)
                .background(.highlight1)
                .clipShape(.buttonBorder)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //            .padding()
            
            Form{
                FormFieldItem(Section: "First Name", TextValue: $firstNameF)
                FormFieldItem(Section: "Last Name", TextValue: $lastNameF)
                FormFieldItem(Section: "Email", TextValue: $emailF)
                Text("Email notifications")
                    .font(.LLSectionCategories)
                CheckFormFieldItem("Order Status", BoolValue: $orderStatus)
                CheckFormFieldItem("Password Changes", BoolValue: $passwordChanges)
                CheckFormFieldItem("Special Offers", BoolValue: $specialOffers)
                CheckFormFieldItem("Newsletter", BoolValue: $newsletter)
            }
            .formStyle(.columns)
            .overlay{
                Image("Logo")
                    .frame(width: 50, height: 110, alignment: .leading)
                    .clipShape(Rectangle())
                    .scaleEffect(CGSize(width: 4, height: 4.0))
                    .grayscale(1)
                    .opacity(0.1)
                    .rotationEffect(.degrees(45))
                    .transformEffect(.init(translationX: 0, y: 50))
            }
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                dismiss()
            }
            .buttonStyle(PrimaryButtonStyle())
            .font(.LLHightlight)
            
            HStack(spacing: 15){
                Button("Discard changes"){
                    // TODO: Discard Form Changes
                }
                .buttonStyle(FilterButtonStyle(padding: 16))
                .font(.LLHightlight)
                
                Button("Save changes"){
                    // TODO: Save Form Changes
                }
                .buttonStyle(FilterButtonStyle(padding: 16))
                .font(.LLHightlight)
            }
            .padding([.top],20)
            
        } // End main VStack
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            ToolbarItem(placement: .principal) {
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 40)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Label("", systemImage: "arrow.left")
                }
                .buttonStyle(SecondaryButtonStyle(padding: 0))
            }
        }
        .onAppear{
            firstNameF = firstName ?? ""
            lastNameF = lastName ?? ""
            emailF = email ?? ""
        }
        .navigationBarBackButtonHidden(true)
    } // End body
    
}

func CheckFormFieldItem(_ label: String, BoolValue: Binding<Bool>) -> some View {
    Label(label, systemImage: BoolValue.wrappedValue ? "checkmark.square.fill" : "square")
        .onTapGesture {
            BoolValue.wrappedValue.toggle()
        }
        .font(.LLParagraph)
        .padding(1)
}

func FormFieldItem(Section: String, TextValue: Binding<String>) -> some View{
    // TODO: Font for entered text?
    VStack{
        Text(Section)
            .font(.LLSectionCategories)
            .foregroundStyle(.form)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField(text:TextValue, prompt: Text("Enter \(Section)...") .font(.LLHightlight)) {
        }
        .onSubmit {
            UserDefaults.standard.set(TextValue, forKey: TextValue.wrappedValue)
        }
        .textFieldStyle(.roundedBorder)
    }
    .padding([.vertical], 2)
}

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

struct FilterButtonStyle: ButtonStyle {
    let height: CGFloat = 40
    let padding: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding([.horizontal],padding)
            .frame(minWidth: height, minHeight: height)
            .background(configuration.isPressed ? .primary1 : .primary2)
            .cornerRadius(16)
    }
}

#Preview {
    UserProfile()
}
