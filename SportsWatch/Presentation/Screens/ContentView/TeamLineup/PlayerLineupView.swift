//
//  PlanerLineupView.swift
//  SportsWatch
//
//  Created by Raul Pena on 03/02/24.
//

import SwiftUI

struct PlayerLineupView: View {
    let player: TeamPlayer
    let width: CGFloat
    let openViewPlayer: ((_ player: TeamPlayer) -> Void)?
    
    var body: some View {
        VStack(alignment: .center, spacing: -40) {
            Image(player.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 210)
            
            ZStack(alignment: .center) {
                ZStack {
                    Color.pink
                    HStack(alignment: .center, spacing: 0) {
                        Text(player.surename)
                            .frame(width: 112)
                            .lineLimit(1)
                            .padding(.vertical, 2)
                            .font(.system(size: 14))
                    }
                    .background(.thickMaterial)
                }
                .frame(maxWidth: 116)
                
                .border(.white, width: 2)
                
                HStack(alignment: .center, spacing: 103) {
                    
                    Text(String(player.number))
                        .frame(width: 17, height: 13)
                        .font(.system(size: 10))
                        .padding(3)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(Circle())
                    
                    Text(player.position.rawValue)
                        .frame(width: 17, height: 13)
                        .font(.system(size: player.position == .midfielder ? 10 : 10))
                        .padding(3)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .contentShape(.hoverEffect, .rect(cornerRadius: 18))
        .hoverEffect()
        .frame(maxWidth: width, maxHeight: 210)
        .onTapGesture { if let openViewPlayer { openViewPlayer(player) } }
        
    }
}

#Preview {
    PlayerLineupView(player: DeveloperPreview.shared.playerRONALDO, width: 150, openViewPlayer: nil)
}
