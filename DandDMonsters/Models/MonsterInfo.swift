//
//  MonsterInfo.swift
//  DandDMonsters
//
//  Created by Robert Beachill on 27/05/2025.
//

import Foundation

struct MonsterInfo: Codable {
    var size: String
    var type: String
    var alignment: String
    var hit_points: Int
    var image: String?
}
