//
//  TrailerPosterView.swift
//  SportsWatch
//
//  Created by Raul Pena on 10/02/24.
//

import SwiftUI

/// A view that displays the poster image with a play button image over it.
struct TrailerPosterView: View {
    let video: Video
    @Environment(PlayerModel.self) private var player
    
    var body: some View {
        ZStack {
            Image(video.landscapeImageName)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 2) {
                if player.isLoadingVideo {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(3.5)
                } else {
                    Image(systemName: "play.fill")
                        .font(.system(size: 74.0))
                        .padding(12)
                        .background(.thinMaterial)
                        .clipShape(.circle)
                    Text("Preview")
                        .font(.title)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 1)
                }
            }
        }
    }
}

#Preview {
    TrailerPosterView(video: DeveloperPreview.shared.video)
}
