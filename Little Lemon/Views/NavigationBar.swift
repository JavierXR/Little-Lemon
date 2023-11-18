//
//  NavigationBar.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/17/23.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        HStack(alignment: .center){
            Spacer()
                .frame(maxWidth: .infinity, alignment: .leading)
            Image("Logo")
            Group {
                Image("profile-image-placeholder")
                    .resizable()
                .frame(width: 50,height: 50)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
                
        }
        .frame(maxWidth: .infinity)
                        .background(.primary2)

        
    }
}

#Preview {
    NavigationBar()
}
