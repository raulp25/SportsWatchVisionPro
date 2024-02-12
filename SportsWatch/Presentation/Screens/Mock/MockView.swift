//
//  MockView.swift
//  SportsWatch
//
//  Created by Raul Pena on 10/02/24.
//

import SwiftUI

struct MockView: View {
    let video: Video
    @Environment(NavigationRouter.self) var navigationRouter
    @Environment(PlayerModel.self) private var player
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                    Text("Go back")
                }
                .padding()
                .foregroundStyle(.white)
                .background(.ultraThinMaterial)
                .hoverEffect()
                .clipShape(Capsule())
                .padding()
                .onTapGesture {
                    self.player.reset()
                    self.navigationRouter.setOrnamentTab(to: .home)
                }
            }
            .padding(.leading, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Nothing to see here but you can play a video")
                        .font(.extraLargeTitle)
                        .fontWeight(.semibold)
                    
                    Image("dog")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                
                VStack {
                    StreamPreview(video: video)
                        .aspectRatio(16 / 9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                }
                .frame(width: 1250, height: 703.12)
                .padding()
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .padding(.top, 15)
            
            
            Spacer()
        }
    }
}

#Preview {
    MockView(video: DeveloperPreview.shared.videoMock)
}
