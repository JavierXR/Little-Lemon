//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.dismiss) var dismiss
    
    let firstNameDefault = UserDefaults.standard.string(forKey: kFirstName)
    let lastNameDefault = UserDefaults.standard.string(forKey: kLastName)
    let emailDefault = UserDefaults.standard.string(forKey: kEmail)
    
    let orderStatusDefault = UserDefaults.standard.bool(forKey: kOrderStatus)
    let passwordChangesDefault = UserDefaults.standard.bool(forKey: kPasswordChanges)
    let specialOffersDefault = UserDefaults.standard.bool(forKey: kSpecialOffers)
    let newsletterDefault = UserDefaults.standard.bool(forKey: kNewsletter)
    
    @State var firstNameField = ""
    @State var lastNameField = ""
    @State var emailField = ""
    
    @State var orderStatusField = false
    @State var passwordChangesField = false
    @State var specialOffersField = false
    @State var newsletterField = false
    
    var body: some View {
        VStack{
            Text("Personal Information")
                .font(.LLLead)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width:75, height: 75, alignment: .leading)
                    .clipShape(Circle()) // remove white background in Dark mode
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
                FormFieldItem(Section: "First Name", TextValue: $firstNameField)
                FormFieldItem(Section: "Last Name", TextValue: $lastNameField)
                FormFieldItem(Section: "Email", TextValue: $emailField)
                Text("Email notifications")
                    .font(.LLSectionCategories)
                CheckFormFieldItem("Order Status", BoolValue: $orderStatusField)
                CheckFormFieldItem("Password Changes", BoolValue: $passwordChangesField)
                CheckFormFieldItem("Special Offers", BoolValue: $specialOffersField)
                CheckFormFieldItem("Newsletter", BoolValue: $newsletterField)
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
                UserDefaults.standard.set("", forKey: kFirstName)
                UserDefaults.standard.set("", forKey: kLastName)
                UserDefaults.standard.set("", forKey: kEmail)
                
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
                    .frame(width: 40, height: 35)
                    .clipShape(Circle()) // remove white background in Dark mode
            }
            ToolbarItem(placement: .principal) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 35)
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
            firstNameField = firstNameDefault ?? ""
            lastNameField = lastNameDefault ?? ""
            emailField = emailDefault ?? ""
            orderStatusField = orderStatusDefault
            passwordChangesField = passwordChangesDefault
            specialOffersField = specialOffersDefault
            newsletterField = newsletterDefault
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    } // End body
    
}

func CheckFormFieldItem(_ label: String, BoolValue: Binding<Bool>) -> some View {
    Label(label, systemImage: BoolValue.wrappedValue ? "checkmark.square.fill" : "square")
        .onTapGesture {
            BoolValue.wrappedValue.toggle()
            UserDefaults.standard.set(BoolValue.wrappedValue, forKey: label)
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
