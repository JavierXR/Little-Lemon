//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

struct FormData {
    var firstNameDefault = UserDefaults.standard.string(forKey: kFirstName) ?? "FormData Error"
    var lastNameDefault = UserDefaults.standard.string(forKey: kLastName) ?? "FormData Error"
    var emailDefault = UserDefaults.standard.string(forKey: kEmail) ?? "FormData Error"
    
    var orderStatusDefault = UserDefaults.standard.bool(forKey: kOrderStatus)
    var passwordChangesDefault = UserDefaults.standard.bool(forKey: kPasswordChanges)
    var specialOffersDefault = UserDefaults.standard.bool(forKey: kSpecialOffers)
    var newsletterDefault = UserDefaults.standard.bool(forKey: kNewsletter)
    
    var tabViewDefault = UserDefaults.standard.bool(forKey: kNavigationStyle)
}


struct UserProfile: View {
    @Environment(\.dismiss) var dismiss

    let largeImageNameDefault = UserDefaults.standard.string(forKey: kProfileImage)
    
    @State var formData = FormData()
    
    // TODO: move to formData like struct?
    @State var showProfilePicker = false
    @State var discardAlert = false
    @State var savedAlert = false
    @State var largeImageName: String = UserDefaults.standard.string(forKey: kProfileImage) ?? "UserProfile.swift Error"
    
    @Binding var navProfileImage: String
    @Binding var tabNavigationStyle: Bool
    
    var body: some View {
        VStack{
            Text("Personal Information")
                .font(.LLLead)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                
                // LARGE PROFILE IMAGE/ICON *
                if largeImageName == "profile-image-placeholder" {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width:75, height: 75, alignment: .leading)
                } else {
                    Image(systemName: largeImageName )
                        .resizable()
                        .scaledToFit()
                        .frame(width:75, height: 75, alignment: .leading)
                }
                Button("Change"){
                    showProfilePicker = true
                }
                .font(.LLHightlight)
                .padding()
                .foregroundStyle(.highlight1)
                .background(.primary1)
                .clipShape(.buttonBorder)
                .sheet(isPresented:$showProfilePicker) {
                    ProfileIconPicker(showProfilePicker: $showProfilePicker, largeImageName: $largeImageName)
                }
                .padding()
                Button("Remove"){
                    largeImageName = "person.crop.circle"
                }
                .font(.LLHightlight)
                .padding()
                .foregroundStyle(.primary1)
                .background(.highlight1)
                .clipShape(.buttonBorder)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Form{
                FormFieldItem(Section: "First Name", TextValue: $formData.firstNameDefault)
                FormFieldItem(Section: "Last Name", TextValue: $formData.lastNameDefault)
                FormFieldItem(Section: "Email", TextValue: $formData.emailDefault)
                Text("Email notifications")
                    .font(.LLSectionCategories)
                CheckFormFieldItem("Order Status", BoolValue: $formData.orderStatusDefault)
                CheckFormFieldItem("Password Changes", BoolValue: $formData.passwordChangesDefault)
                CheckFormFieldItem("Special Offers", BoolValue: $formData.specialOffersDefault)
                CheckFormFieldItem("Newsletter", BoolValue: $formData.newsletterDefault)
                
                Text("App Settings")
                    .font(.LLSectionCategories)
                CheckFormFieldItem("Tab View", BoolValue: $formData.tabViewDefault)
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
                UserDefaults.standard.set(true, forKey: kNavigationStyle)
                UserDefaults.standard.set("profile-image-placeholder", forKey: kProfileImage)
                dismiss()
            }
            .buttonStyle(PrimaryButtonStyle())
            .font(.LLHightlight)
            .padding(.top, tabNavigationStyle ? 0 : 30)
            
            HStack(spacing: 15){
                Button("Discard changes"){
                    formData.firstNameDefault = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    formData.lastNameDefault = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    formData.emailDefault = UserDefaults.standard.string(forKey: kEmail) ?? ""
                    largeImageName = UserDefaults.standard.string(forKey: kProfileImage) ?? "nil-coalescing"
                    
                    formData.orderStatusDefault = UserDefaults.standard.bool(forKey: kOrderStatus)
                    formData.passwordChangesDefault = UserDefaults.standard.bool(forKey: kPasswordChanges)
                    formData.specialOffersDefault = UserDefaults.standard.bool(forKey: kSpecialOffers)
                    formData.newsletterDefault = UserDefaults.standard.bool(forKey: kNewsletter)
                    
                    formData.tabViewDefault = UserDefaults.standard.bool(forKey: kNavigationStyle)

                    discardAlert.toggle()
                }
                .buttonStyle(FilterButtonStyle(padding: 16))
                .font(.LLHightlight)
                .alert(
                    "Success",
                    isPresented: $discardAlert
                ) {
                    Button("OK") {
                    }
                } message: {
                    //TODO: if no changes were made, display error message
                    Text("Changes were discarded.")
                }
                
                Button("Save changes"){
                    UserDefaults.standard.set(formData.firstNameDefault, forKey: kFirstName)
                    UserDefaults.standard.set(formData.lastNameDefault, forKey: kLastName)
                    UserDefaults.standard.set(formData.emailDefault, forKey: kEmail)
                    UserDefaults.standard.set(formData.orderStatusDefault, forKey: kOrderStatus)
                    UserDefaults.standard.set(formData.passwordChangesDefault, forKey: kPasswordChanges)
                    UserDefaults.standard.set(formData.specialOffersDefault, forKey: kSpecialOffers)
                    UserDefaults.standard.set(formData.newsletterDefault, forKey: kNewsletter)
                    UserDefaults.standard.set(largeImageName, forKey: kProfileImage)
                    navProfileImage = largeImageName
                    
                    // TabView vs. StackView
                    UserDefaults.standard.set(formData.tabViewDefault, forKey: kNavigationStyle)
                    
                    var shouldDismiss = false
                    if formData.tabViewDefault && tabNavigationStyle != formData.tabViewDefault {
                        shouldDismiss = true
                    }
                    tabNavigationStyle = formData.tabViewDefault

                    if shouldDismiss{
                            dismiss()
                    }
                    
                    savedAlert.toggle()
                }
                .buttonStyle(FilterButtonStyle(padding: 16))
                .font(.LLHightlight)
                .alert(
                    "Success",
                    isPresented: $savedAlert
                ) {
                    Button("OK") {
                        // TODO: Keep User Profile screen from dismissing when disabling TabView navigation

                    }
                } message: {
                    //TODO: if no changes were made, display error message
                    Text("Changes were saved.")
                }
            }
            .padding(.top, tabNavigationStyle ? 8 : 20)
            
        } // End main VStack
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                if UserDefaults.standard.string(forKey: kProfileImage) == "profile-image-placeholder" {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width:40, height: 35, alignment: .leading)
                } else {
                    Image(systemName: UserDefaults.standard.string(forKey: kProfileImage) ?? "nil-coalescing")
                        .font(.system(size: 25))
                }
            }
            ToolbarItem(placement: .principal) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 35)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .cancel) {
                    //  DISMISSING ICON PRESSED
                    dismiss()
                } label: {
                    Label("", systemImage: "arrow.left")
                }
                .buttonStyle(SecondaryButtonStyle(padding: 0))
            }
        }
        .onAppear{
            formData.firstNameDefault = UserDefaults.standard.string(forKey: kFirstName) ?? ""
            formData.lastNameDefault = UserDefaults.standard.string(forKey: kLastName) ?? ""
            formData.emailDefault = UserDefaults.standard.string(forKey: kEmail) ?? ""
            largeImageName = UserDefaults.standard.string(forKey: kProfileImage) ?? "nil-coalescing"
            
            formData.orderStatusDefault = UserDefaults.standard.bool(forKey: kOrderStatus)
            formData.passwordChangesDefault = UserDefaults.standard.bool(forKey: kPasswordChanges)
            formData.specialOffersDefault = UserDefaults.standard.bool(forKey: kSpecialOffers)
            formData.newsletterDefault = UserDefaults.standard.bool(forKey: kNewsletter)
            
            formData.tabViewDefault = UserDefaults.standard.bool(forKey: kNavigationStyle)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
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

#Preview("Navigation Stack") {
    NavigationStack{
        UserProfile(navProfileImage: .constant("profile-image-placeholder"), tabNavigationStyle: .constant(true))
    }
}
