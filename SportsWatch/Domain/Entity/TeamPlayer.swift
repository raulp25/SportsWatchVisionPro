//
//  TeamPlayer.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import Foundation

struct TeamPlayer: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let name: String
    let surename: String
    let number: Int
    let imageUrl: String
    let position: PlayerPosition
    let lefStats: [PlayerStats]
    let rightStats: [PlayerStats]
}

enum PlayerPosition: String {
    case goalkeeper = "GK"
    case defense = "D"
    case striker = "S"
    case midfielder = "MD"
}

struct PlayerStats: Identifiable, Hashable {
    let id = UUID().uuidString
    let range: Int
    let acronym: String
}
