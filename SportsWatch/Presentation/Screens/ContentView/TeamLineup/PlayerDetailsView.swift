//
//  PlayerDetails.swift
//  SportsWatch
//
//  Created by Raul Pena on 10/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PlayerDetailsView: View {
    let currentPlayer: TeamPlayer
    let modelDepth: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            VStack(spacing: 10){
                Text("90")
                    .font(.extraLargeTitle)
                    .padding(.top, 20)
                
                Text("ST")
                    .font(.title)
                VStack{}
                    .frame(width: 40, height: 2)
                    .background(.white)
                
                Text("🇵🇹")
                    .font(.system(size: 60))
                VStack{}
                    .frame(width: 40, height: 2)
                    .background(.white)
                
                Image("manchester-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                
                Spacer()
            }
            .padding(.leading, 90)
            
            VStack {
                Color.clear
                    .overlay {
                        PlayerItemView(player: currentPlayer, orientation: [-0.1, -0.1, 0], modelDepth: modelDepth)
                    }
                    .dragRotation(yawLimit: .degrees(80), pitchLimit: .degrees(20))
                    .offset(z: modelDepth)
            }
            .frame(maxWidth: 250, maxHeight: 300, alignment: .center)
            .padding(.top, 220)
            Spacer()
        }
        .frame(maxHeight: 370)
    }
}

#Preview {
    PlayerDetailsView(currentPlayer: DeveloperPreview.shared.playerRONALDO, modelDepth: 25)
}

private struct PlayerItemView: View {
    var player: TeamPlayer
    var orientation: SIMD3<Double> = .zero
    var modelDepth: CGFloat
    
    var offset: CGFloat {
        player.position == .midfielder
        ? 60
        : -modelDepth / 2
    }
    
    var body: some View {
        Model3D(named: player.position == .midfielder ? "Skull" : "PlayerFront", bundle: realityKitContentBundle) { model in
            model.resizable()
                .scaledToFit()
                .rotation3DEffect(
                    Rotation3D(
                        eulerAngles: .init(angles: orientation, order: .xyz)
                    )
                )
                .frame(depth: modelDepth)
                .offset(z: offset)
            
        } placeholder: {
            ProgressView()
                .offset(z: -modelDepth * 0.75)
        }
    }
}
