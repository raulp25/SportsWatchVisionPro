//
//  Team.swift
//  SportsWatch
//
//  Created by Raul Pena on 30/01/24.
//

import Foundation

struct Team: Identifiable {
    let id = NSUUID().uuidString
    
    let name: String
    let imageUrl: String
    let tablePosition: Int
    let gamesPlayed: Int
    let gamesWin: Int
    let gamesLost: Int
    let players: [TeamPlayer]
}


