//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

import SwiftUI

let persistence = PersistenceController()

@main
struct Little_LemonApp: App {

    var body: some Scene {
        WindowGroup {
            Onboarding()
        }
    }
}
