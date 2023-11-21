//
//  NavigationLogo.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/21/23.
//

import SwiftUI

struct NavigationLogo: View {
    var body: some View {
        Image("Logo")
            .resizable()
            .scaledToFit()
        .frame(width: 200, height: 35)
    }
}

#Preview {
    NavigationLogo()
}
