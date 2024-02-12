//
//  InlinePlayerView.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI
import AVKit

struct InlinePlayerView: View {
    let video: Video
    @Environment(PlayerModel.self) private var player
    
    @State private var isShowingControls = true
    @State private var isPosterVisible = true
    
    var body: some View {
        GeometryReader { proxy in
            let controlsBarWidth = proxy.size.width * 0.85
            if isPosterVisible && player.currentItem == nil {
                TrailerPosterView(video: video)
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .contentShape(.hoverEffect, .rect(cornerRadius: 20))
                        .hoverEffect()
                        .onTapGesture {
                            player.isLoadingVideo = true
                            // Give the progress view loader one second to play in the UI
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    player.loadVideo(video)
                                    withAnimation {
                                        isPosterVisible = false
                                    }
                                }
                        }
            } else {
                ZStack {
                    // A view that uses AVPlayerViewController to display the video content without controls.
                    VideoContentView()
                        .onTapGesture {
                            isShowingControls.toggle()
                        }
                    
                    if player.isReplayBtnVisible {
                            HStack {
                                Image(systemName: "arrow.counterclockwise")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                            }
                            .padding(20)
                            .foregroundStyle(.white)
                            .glassBackgroundEffect(displayMode: .always)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .contentShape(.hoverEffect, .rect(cornerRadius: 32))
                            .hoverEffect()
                            .onTapGesture { player.replay() }
                        
                    }
                    
                    if player.isPlayingAlternativeMediaOnMatch {
                        VStack(alignment: .leading) {
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
                                player.isPlayingAlternativeMediaOnMatch = false
                                player.hideReplayBtn()
                                player.pause()
                                player.loadVideo(DeveloperPreview.shared.video, autoplay: false)
                                
                                player.isInitialState.toggle()
                                player.scrubState = .reset
                                
                                if  player.shouldAutoPlay {
                                    player.wasPlaying = true
                                    player.play()
                                } else {
                                    player.wasPlaying = false
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture { isShowingControls.toggle() }
                        
                    }
                    // Custom inline controls to overlay on top of the video content.
                    VStack {
                        Spacer()
                        InlineControlsView(isShowingControls: $isShowingControls, sliderWidth: controlsBarWidth)
                            .frame(maxWidth: controlsBarWidth)
                            .glassBackgroundEffect(displayMode: .always)
                            .opacity(isShowingControls ? 1 : 0)
                    }
                    .padding()
                    
                }
                .onAppear { if player.shouldAutoPlay { player.play() } }
                .onChange(of: player.currentItem) { oldValue, newValue in
                    isShowingControls = true
                }
            }
        }
        .onDisappear {
            player.reset()
        }
    }
}


/// A view that presents the video content of an player object.
///
/// This class is a view controller representable type that adapts the interface
/// of AVPlayerViewController. It disables the view controller's default controls
/// so it can draw custom controls over the video content.
private struct VideoContentView: UIViewControllerRepresentable {
    @Environment(PlayerModel.self) private var model
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = model.makePlayerViewController()
        // Disable the default system playback controls.
        controller.showsPlaybackControls = false
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

#Preview {
    InlinePlayerView(video: DeveloperPreview.shared.video)
        .environment(PlayerModel())
    
}

 
