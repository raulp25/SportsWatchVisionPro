//
//  TeamLineupView.swift
//  SportsWatch
//
//  Created by Raul Pena on 03/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

private let modelDepth: Double = 20

struct TeamLineupView: View {
    let teamPlayers: [TeamPlayer]
    let width: CGFloat = 150
    let maxWidth: CGFloat
    
    @State private var viewPlayer = false
    @State private var currentPlayer: TeamPlayer? = nil
    
    var body: some View {
        let columns = [GridItem(.adaptive(minimum: width, maximum: width), spacing: 20)]
        
        VStack {
            if !viewPlayer {
                HStack(alignment: .center, spacing: 10) {
                    Image("manchester-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                    Text("Team Members")
                        .font(.title)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 70) {
                        ForEach(teamPlayers) { player in
                            PlayerLineupView(player: player, width: width) { player in
                                currentPlayer = player
                                viewPlayer = true
                            }
                            
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            } else {
                HStack {
                    Button {
                        viewPlayer = false
                    } label: {
                        Text("Go back")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                if let currentPlayer {
                    VStack {
                        ScrollView {
                            PlayerDetailsView(currentPlayer: currentPlayer, modelDepth: modelDepth)
                            .frame(maxHeight: 370)
                            
                            
                            PlayerStatsView(currentPlayer: currentPlayer)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 459)
                            .frame(maxHeight: .infinity)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                        }
                    }
                    .background(.thinMaterial)
                    .background(Image("purple-bg").resizable().scaledToFill().clipShape(RoundedRectangle(cornerRadius: 22)))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                }
            }
        }
        .frame(maxDepth: maxWidth)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    TeamLineupView(teamPlayers: DeveloperPreview.shared.players, maxWidth: 500)
}



