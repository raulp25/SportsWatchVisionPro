//
//  InteractiveMatchOptionView+Types.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import Foundation

struct InteractiveMatchOption: Identifiable {
    let id = NSUUID().uuidString
    let icon: String
    let title: String
    let imageUrl: String
    let imageIcon: String?
    let subscriptionDetails: InteractiveMatchOptionSubscriptionDetails?
    let type: InteractiveMatchOptionType
    let immersiveSpace: SpaceDestination?
    let threeSixtyVideo: SpaceDestination?
    let volume: SpaceDestination?
    let popup: Popup?
    
}

struct InteractiveMatchOptionSubscriptionDetails {
    let icon: String?
    let caption: String?
    let buttonText: String?
}

enum InteractiveMatchOptionType {
    case immersive
    case volume
    case popup
    case threeSixtyView
}

struct SpaceDestination: Codable, Hashable {
    let id = NSUUID().uuidString
    let url: String
}

struct Popup: Codable, Hashable {
    let title: String
    let caption: String?
    let buttonText: String?
}
