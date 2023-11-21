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
    var profileDefault = UserDefaults.standard.string(forKey: kEmail) ?? "FormData Error"

    
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
            
            // Profile Image editor
            ProfileImageEditor(largeImageName: $largeImageName, showProfilePicker: $showProfilePicker)
            
            // Displays an editable Form Field
            Form{
                populateFormField()
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
            
            // Logout by dismissing current view. TODO: Dismiss directly to Onboarding screen when Navigation Stack mode active
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                dismiss()
            }
            .buttonStyle(PrimaryButtonStyle())
            .font(.LLHightlight)
            .padding(.top, tabNavigationStyle ? 0 : 30)
            
            HStack(spacing: 15){
                Button("Discard changes"){
                    discardFormChanges()
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
                    // Save changes to User Defaults
                    saveUserDefaults()
                    
                    // Update navProfileImage binding
                    navProfileImage = largeImageName
                    
                    // TabView vs. StackView
                    UserDefaults.standard.set(formData.tabViewDefault, forKey: kNavigationStyle)
                    
                    // Update alert binding present alert
                    savedAlert.toggle()
//                    tabNavigationStyle = formData.tabViewDefault
                    
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
                            if formData.tabViewDefault && tabNavigationStyle != formData.tabViewDefault {
                                shouldDismiss = true
                            }
                            
                            tabNavigationStyle = formData.tabViewDefault

                            if shouldDismiss{
                                dismiss()
                            }
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
            // Trailing Profile Image Icon
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
            // Centered Logo ToolbarItem
            ToolbarItem(placement: .principal) {
                NavigationLogo()
            }
            // Leading "Back" ToolbarItem
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
               discardFormChanges()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    } // End body
    
    /// Discards all changes by reverting formData to UserDefaults
    func discardFormChanges() {
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
    
    /// Saves UserDefaults values
    func saveUserDefaults(){
        UserDefaults.standard.set(formData.firstNameDefault, forKey: kFirstName)
        UserDefaults.standard.set(formData.lastNameDefault, forKey: kLastName)
        UserDefaults.standard.set(formData.emailDefault, forKey: kEmail)
//        UserDefaults.standard.set(formData.profileDefault,forKey: kProfileImage) // TODO: issue?
        UserDefaults.standard.set(formData.orderStatusDefault, forKey: kOrderStatus)
        UserDefaults.standard.set(formData.passwordChangesDefault, forKey: kPasswordChanges)
        UserDefaults.standard.set(formData.specialOffersDefault, forKey: kSpecialOffers)
        UserDefaults.standard.set(formData.newsletterDefault, forKey: kNewsletter)
        UserDefaults.standard.set(largeImageName, forKey: kProfileImage)
    }
    
    /// Populates the form with FormFieldItem's and CheckmarkFormFieldItem's
    func populateFormField() -> some View{
        Group {
            FormFieldItem(Section: "First Name", TextValue: $formData.firstNameDefault)
            FormFieldItem(Section: "Last Name", TextValue: $formData.lastNameDefault)
            FormFieldItem(Section: "Email", TextValue: $formData.emailDefault)
            
            Text("Email notifications")
                .font(.LLSectionCategories)
            CheckmarkFormFieldItem("Order Status", BoolValue: $formData.orderStatusDefault)
            CheckmarkFormFieldItem("Password Changes", BoolValue: $formData.passwordChangesDefault)
            CheckmarkFormFieldItem("Special Offers", BoolValue: $formData.specialOffersDefault)
            CheckmarkFormFieldItem("Newsletter", BoolValue: $formData.newsletterDefault)
            
            Text("App Settings")
                .font(.LLSectionCategories)
            CheckmarkFormFieldItem("Tab View", BoolValue: $formData.tabViewDefault)
        }
    }
}

#Preview("Navigation Stack") {
    NavigationStack{
        UserProfile(navProfileImage: .constant("profile-image-placeholder"), tabNavigationStyle: .constant(true))
    }
}
