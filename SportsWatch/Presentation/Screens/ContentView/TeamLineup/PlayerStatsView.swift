//
//  PlayerStatsView.swift
//  SportsWatch
//
//  Created by Raul Pena on 10/02/24.
//

import SwiftUI

struct PlayerStatsView: View {
    let currentPlayer: TeamPlayer
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                VStack(alignment: .center, spacing: 20) {
                    Text("\(currentPlayer.name) \(currentPlayer.surename)")
                        .font(.system(size: 60, weight: .light))
                    
                    VStack{}
                        .frame(maxWidth: 360)
                        .frame(height: 2)
                        .background(.white)
                }
                
                HStack(alignment: .center, spacing: 40) {
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(currentPlayer.lefStats) { stat in
                            HStack(alignment: .center, spacing: 5) {
                                Text(String(stat.range))
                                    .frame(width: 50, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(stat.acronym)
                                    .frame(width: 70, alignment: .leading)
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: 130)
                        }
                    }
                    
                    VStack{}
                        .frame(width: 2 , height: 180)
                        .background(.white)
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        ForEach(currentPlayer.rightStats) { stat in
                            HStack(alignment: .center, spacing: 5) {
                                Text(String(stat.range))
                                    .frame(width: 50, alignment: .leading)
                                    .fontWeight(.bold)
                                Text(stat.acronym)
                                    .frame(width: 70, alignment: .leading)
                                    .multilineTextAlignment(.trailing)
                            }
                            .frame(width: 130)
                        }
                    }
                    .padding(.leading, 12)
                }
                .font(.system(size: 30, weight: .regular))
                .padding(.top, 20)
                
                VStack{}
                    .frame(width: 50, height: 2)
                    .background(.white)
                    .padding(.trailing, 10)
                
                Spacer()
            }
            .padding(.top, 30)
            
        }
    }
}

#Preview {
    PlayerStatsView(currentPlayer: DeveloperPreview.shared.playerRONALDO)
}
