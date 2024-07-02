//
//  ContentView.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI

private enum Item: String, CaseIterable, Identifiable {
    case score, timeline, lineup = "line-up", stats
    var id: Self { self }
    var name: String { rawValue.capitalized }
}


struct ContentView: View {
    
    let video: Video
    @Environment(NavigationRouter.self) var navigationRouter
    
    @State private var searchText = ""
    @State private var selection: Item = .score
    @State private var isPresentingSpace: Bool = false
    @State private var currentSpaceDestination: SpaceDestination?
    
    var body: some View {
            GeometryReader { proxy in
                let matchOptionsWidth = proxy.size.width * 0.3
                VStack {
                    // Video Player and Stats
                    HStack {
                        /* Video Player */
                        VStack {
                            HeaderView(searchText: $searchText)
                            VStack {
                                StreamPreview(video: video)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 17))
                            }
                            .padding()
                            .background(.thickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .padding(.top, 5)
                            Spacer()
                        }
                        
                        /* Game Data */
                        if self.navigationRouter.currentOrnamentTab == .allMode {
                            VStack {
                                Picker("Match-Options", selection: $selection) {
                                    ForEach(Item.allCases) { item in
                                        Text(item.name)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .padding(.bottom, 5)
    
                                if selection == .score {
                                    VStack {
                                        MatchScoreView(matchInfo: DeveloperPreview.shared.matchInfo, maxWidth: matchOptionsWidth)
                                    }
                                    .padding(.horizontal, 5)
                                    
                                    ScrollView {
                                        RoundMatchesResultsView(matches: DeveloperPreview.shared.matchesArr, maxWidth: matchOptionsWidth)
                                        
                                        LeagueGeneralPositionsTableView(teams: DeveloperPreview.shared.teams, maxWidth: matchOptionsWidth)
                                            .padding(.top, 5)
                                    }
                                    .padding(.top, 15)
                                }
                                
                                if selection == .timeline {
                                    ScrollView {
                                        TimeLineEventsView(timeLineEvents: DeveloperPreview.shared.timeLineEvents, maxWidth: matchOptionsWidth)
                                    }
                                }
                                
                                if selection == .lineup {
                                    TeamLineupView(teamPlayers: DeveloperPreview.shared.players, maxWidth: matchOptionsWidth)
                                }
                                
                                Spacer()
                            }
                            .frame(width: matchOptionsWidth)
                            .padding()
                        }
                    }
                    
                    // Bottom Match Options Cards View -> Become member | 360 | Immersive Space (Stadium View, Locker Room View)
                    if self.navigationRouter.currentOrnamentTab == .allMode {
                        ScrollView(.horizontal) {
                            HStack(spacing: 20){
                                ForEach(DeveloperPreview.shared.interactiveMatchOptions) { option in
                                    InteractiveMatchOptionView(interactiveMatchOption: option,
                                                               isPresentingSpace: $isPresentingSpace)
                                        .contentShape(.hoverEffect, .rect(cornerRadius: 20))
                                        .hoverEffect()
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .padding(.bottom, 15)
                        .scrollTargetBehavior(.viewAligned)
                        .scrollClipDisabled()
                    }
                }
                .padding()
            }
        }
    
}

#Preview(windowStyle: .automatic) {
    ContentView(video: DeveloperPreview.shared.video)
}
