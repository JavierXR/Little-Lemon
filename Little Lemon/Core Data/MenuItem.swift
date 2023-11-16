//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Javier Brito on 11/16/23.
//

import Foundation

struct MenuItem: Decodable {
    let id: Int
    let title, summary, price, image, category: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, image, category
        case summary = "description"
    }
    
}
