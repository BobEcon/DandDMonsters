//
//  Monster.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 23/05/2025.
//

import Foundation

struct Monster: Codable, Identifiable {
    let id = UUID().uuidString
    var index: String
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case index
        case name
        case url
    }
}
