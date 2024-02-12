//
//  TimeLineEventsView+Types.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import Foundation

struct TimeLineEvent: Identifiable {
    let id = NSUUID().uuidString
    let type: TimeLineType
    let timeLineCardShownEvent: TimeLineCardShownEvent?
    let timeLineGoalEvent: TimeLineGoalEvent?
    let timeLineSwitchPlayerEvent: TimeLineSwitchPlayerEvent?
}


struct TimeLineEventGeneralrData {
    let playerName: String
    let minute: Int
    let position: String
    let teamImageUrl: String
}

struct TimeLineCardShownEvent {
    let data: TimeLineEventGeneralrData
}

struct TimeLineGoalEvent {
    let data: TimeLineEventGeneralrData
    let previewImageUrl: String
    let video: Video
}

struct TimeLineSwitchPlayerEvent {
    let data: TimeLineEventGeneralrData
    let entryPlayerData: TimeLineEventGeneralrData
}

enum TimeLineType: String, Equatable {
    case yellowCard, redCard, goal, switchPlayer, matchEnded
}
