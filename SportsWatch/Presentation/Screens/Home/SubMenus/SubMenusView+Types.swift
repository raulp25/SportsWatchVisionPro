//
//  SubMenusView+Types.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import Foundation

struct SubMenu: Hashable {
    let title: String
    let caption: String?
    let doubleline: Bool
    let backgroundImageUrl: String?
    let iconName: String
    let type: SubMenuType
}

enum SubMenuType {
    case football, mockView
}
