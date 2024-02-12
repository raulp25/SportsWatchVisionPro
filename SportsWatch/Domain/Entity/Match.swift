//
//  Match.swift
//  SportsWatch
//
//  Created by Raul Pena on 30/01/24.
//

import Foundation

struct MatchInfo: Identifiable {
    let visitantTeam: Team
    let localTeam: Team
    let visitantTeamScore: Int
    let localTeamScore: Int
    let stats: [MatchInfoStat]
    let id = NSUUID().uuidString
    
}

struct MatchInfoStat: Identifiable {
    var id = NSUUID().uuidString
    
    let type: MatchInfoStatType
    let caption: String
}

enum MatchInfoStatType: String, Identifiable, CaseIterable {
    case goal, yellowCard, redCard, playerChange, injury, suspended, finished
    var id: Self { self }
}
