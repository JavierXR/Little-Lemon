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
    let largeImageNameDefault = UserDefaults.standard.string(forKey: kProfileImage)
    
    let orderStatusDefault = UserDefaults.standard.bool(forKey: kOrderStatus)
    let passwordChangesDefault = UserDefaults.standard.bool(forKey: kPasswordChanges)
    let specialOffersDefault = UserDefaults.standard.bool(forKey: kSpecialOffers)
    let newsletterDefault = UserDefaults.standard.bool(forKey: kNewsletter)
    let navigationStyleDefault = UserDefaults.standard.bool(forKey: kNavigationStyle)
    
    @State var firstNameField = ""
    @State var lastNameField = ""
    @State var emailField = ""
    
    @State var orderStatusField = false
    @State var passwordChangesField = false
    @State var specialOffersField = false
    @State var newsletterField = false
    @State private var tabViewField = true
    
    @State var discardAlert = false
    @State var savedAlert = false
    
    @State var showProfilePicker = false
    
    @State var largeImageName: String = UserDefaults.standard.string(forKey: kProfileImage) ?? "UserProfile.swift Error"
    
    @Binding var navProfileImage: String
    
    @Binding var tabView: Bool
    
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
                
                Text("App Settings")
                    .font(.LLSectionCategories)
                CheckFormFieldItem("Tab View", BoolValue: $tabViewField)
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
            .padding(.top, 30)
            
            HStack(spacing: 15){
                Button("Discard changes"){
                    firstNameField = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                    lastNameField = UserDefaults.standard.string(forKey: kLastName) ?? ""
                    emailField = UserDefaults.standard.string(forKey: kEmail) ?? ""
                    largeImageName = UserDefaults.standard.string(forKey: kProfileImage) ?? "nil-coalescing"
                    
                    orderStatusField = UserDefaults.standard.bool(forKey: kOrderStatus)
                    passwordChangesField = UserDefaults.standard.bool(forKey: kPasswordChanges)
                    specialOffersField = UserDefaults.standard.bool(forKey: kSpecialOffers)
                    newsletterField = UserDefaults.standard.bool(forKey: kNewsletter)
                    
                    tabViewField = UserDefaults.standard.bool(forKey: kNavigationStyle)

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
                    UserDefaults.standard.set(firstNameField, forKey: kFirstName)
                    UserDefaults.standard.set(lastNameField, forKey: kLastName)
                    UserDefaults.standard.set(emailField, forKey: kEmail)
                    UserDefaults.standard.set(orderStatusField, forKey: kOrderStatus)
                    UserDefaults.standard.set(passwordChangesField, forKey: kPasswordChanges)
                    UserDefaults.standard.set(specialOffersField, forKey: kSpecialOffers)
                    UserDefaults.standard.set(newsletterField, forKey: kNewsletter)
                    UserDefaults.standard.set(largeImageName, forKey: kProfileImage)
                    navProfileImage = largeImageName
                    
                    // TabView vs. StackView
                    UserDefaults.standard.set(tabViewField, forKey: kNavigationStyle)

                    
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
                        var shouldDismiss = false
                        if tabViewField && tabView != tabViewField {
                            shouldDismiss = true
                        }
                        tabView = tabViewField
                        if shouldDismiss{
                            dismiss()
                        }
                    }
                } message: {
                    //TODO: if no changes were made, display error message
                    Text("Changes were saved.")
                }
            }
            .padding([.top],20)
            
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
            firstNameField = firstNameDefault ?? ""
            lastNameField = lastNameDefault ?? ""
            emailField = emailDefault ?? ""
            orderStatusField = orderStatusDefault
            passwordChangesField = passwordChangesDefault
            specialOffersField = specialOffersDefault
            newsletterField = newsletterDefault
            tabViewField = navigationStyleDefault
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

#Preview {
    NavigationStack{
        UserProfile(navProfileImage: .constant("profile-image-placeholder"), tabView: .constant(true))
    }
}
