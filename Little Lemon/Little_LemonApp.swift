//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/15/23.
//

// TODO: Refactor code -> helper/util file -> more comments -> Unit Tests -> current TODO's

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
