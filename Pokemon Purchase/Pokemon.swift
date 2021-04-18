//
//  Pokemon.swift
//  Pokemon Purchase
//
//  Created by William Jones on 4/17/21.
//

import Foundation

struct Pokemon {
    let name: String
    let baseExperience: Int
    var purchasePrice: Float {
        // calculated field for pokemon price: (1% of baseExperience) * 6
        return (0.01 * Float(baseExperience)) * 6
    }
    
    init(name: String, baseExperience: Int) {
        self.name = name
        self.baseExperience = baseExperience
    }
}
