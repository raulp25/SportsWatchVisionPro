//
//  Ornament.swift
//  SportsWatch
//
//  Created by Raul Pena on 05/02/24.
//

import SwiftUI

struct OrnamentView: View {
    @Environment(NavigationRouter.self) var navigationRouter
    @Environment(PlayerModel.self) var player
    
    var body: some View {
        HStack(alignment: .center, spacing: 45) {
            ForEach(OrnamentTab.allCases) { section in
                HStack {
                    Text(section.rawValue)
                        .font(.title2)
                }
                .frame(minWidth: 120)
                .padding(.horizontal, section == .tvBroadcaste ? 20 : 10)
                .padding(.vertical, 10)
                .background(navigationRouter.currentOrnamentTab == section ? .white.opacity(0.3) : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(.hoverEffect, .rect(cornerRadius: 32))
                .hoverEffect()
                .disabled(checkDisable(section: section))
                .onTapGesture {
                   handleTap(for: section)
                }
            }
        }
        .padding()
        .padding(.horizontal, 20)
        .frame(minWidth: 1200)
        .onChange(of: navigationRouter.currentOrnamentTab) { oldValue, newValue in
            switch newValue {
            case .home:
                player.reset()
            default: return
            }
        }
    }
    
    
    private func checkDisable(section: OrnamentTab) -> Bool{
        switch section {
        case .tvBroadcaste, .allMode: self.navigationRouter.currentRoute != .football
        default: false
        }
    }
    
    private func handleTap(for tab: OrnamentTab) {
        switch tab {
        case .home:
            self.navigationRouter.setOrnamentTab(to: tab)
        case .football, .nfl, .nba:
            self.navigationRouter.setOrnamentTab(to: tab)
        case .allMode, .tvBroadcaste:
            self.navigationRouter.setOrnamentTab(to: tab)
        }
    }
}

#Preview {
    let navigationRouter: NavigationRouter = NavigationRouter()
    return OrnamentView()
        .environment(navigationRouter)
}
