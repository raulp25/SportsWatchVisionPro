//
//  InlineControlsView.swift
//  SportsWatch
//
//  Created by Raul Pena on 10/02/24.
//

import SwiftUI
import AVKit

/// A view that defines a simple play/pause/replay button for the trailer player.
struct InlineControlsView: View {
    @Environment(PlayerModel.self) private var playerModel
    @Environment(NavigationRouter.self) private var navigationRouter
    @Binding var isShowingControls: Bool
    var sliderWidth: CGFloat
    
    @State var dismissTask: Task<Void, Never>? = nil
    
    @State private var isPlaying = true
    @State private var videoCurrentTime : Double = 0
    
    var body: some View {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "gobackward.10")
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(.circle)
                    .contentShape(.hoverEffect, .rect(cornerRadius: 28))
                    .hoverEffect()
                    .onTapGesture {
                        playerModel.videoChangeTime(isForward: false)
                        dismissTask?.cancel()
                        dismissAfterDelay()
                    }
                    
                Button {
                    if playerModel.isReplayBtnVisible {
                        playerModel.replay()
                    } else {
                        playerModel.togglePlayback()
                    }
                } label: {
                    Image(systemName: playerModel.isPlaying
                          ? "pause.fill"
                          : playerModel.isReplayBtnVisible
                            ? "arrow.counterclockwise"
                            : "play.fill")
                        .padding(8)
                }
                .clipShape(.circle)
                
                Image(systemName: "goforward.10")
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(.circle)
                    .contentShape(.hoverEffect, .rect(cornerRadius: 28))
                    .hoverEffect()
                    .onTapGesture {
                        playerModel.videoChangeTime(isForward: true)
                        dismissTask?.cancel()
                        dismissAfterDelay()
                    }
                
                Text(durationFormatter.string(from: videoCurrentTime) ?? "0:00")
                    .frame(width: 150)

                if playerModel.itemDuration > 0 {
                    Slider(value: self.$videoCurrentTime, in: (0...playerModel.itemDuration), onEditingChanged: {
                        (scrubStarted) in
                        if scrubStarted {
                            playerModel.scrubState = .scrubStarted
                            playerModel.pause()
                        } else {
                            playerModel.scrubState = .scrubEnded(videoCurrentTime)
                            if playerModel.wasPlaying {
                                playerModel.play()
                            }
                        }
                    })
                    .tint(.white.opacity(0.6))
                    .foregroundStyle(Color(uiColor: .lightGray))
                } else {
                    Slider(value: $videoCurrentTime, in: 0...10)
                        .tint(.white.opacity(0.6))
                        .foregroundStyle(Color(uiColor: .lightGray))
                }
                Text(playerModel.isPlaying ? "Live" : "Not live")
                    .frame(width: 150)
                
                HStack(alignment: .center, spacing: 30) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.bubble.fill")
                            .scaledToFit()
                            .contentShape(.interaction, .rect)
                            .contentShape(.hoverEffect, .rect(cornerRadius: 0))
                            .padding(5)
                            .onTapGesture { }
                        
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: 50)
                    /* Prefer Image component over Button since they wont work correctly in the simulator
                       if they are close to other buttons or who knows... */
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding(8)
                        .clipShape(.circle)
                        .contentShape(.hoverEffect, .rect(cornerRadius: 28))
                        .hoverEffect()
                        .onTapGesture {
                            if navigationRouter.currentOrnamentTab == .allMode {
                                navigationRouter.setOrnamentTab(to: .tvBroadcaste)
                            } else if navigationRouter.currentOrnamentTab == .tvBroadcaste {
                                navigationRouter.setOrnamentTab(to: .allMode)
                            }
                        }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .scaledToFit()
                            .contentShape(.interaction, .rect)
                            .contentShape(.hoverEffect, .rect(cornerRadius: 0))
                            .padding(16)
                            .onTapGesture { }
                        
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: 50)
                }
                
            }
            .padding()
            .padding(.horizontal, 20)
            .font(.largeTitle)
            .onChange(of: videoCurrentTime, { oldValue, newValue in
                if  playerModel.scrubState == .scrubStarted {
                    
                    playerModel.player.seek(to: CMTime(seconds: floor(videoCurrentTime),
                                                       preferredTimescale: playerModel.timeScale),
                                            toleranceBefore: .zero,
                                            toleranceAfter: .zero)
                    playerModel.scrubState = .scrubContinues(videoCurrentTime)
                    dismissTask?.cancel()
                } else {
                    switch playerModel.scrubState {
                    case .scrubContinues(_):
                        playerModel.player.seek(to: CMTime(seconds: floor(videoCurrentTime),
                                                           preferredTimescale: playerModel.timeScale),
                                                toleranceBefore: .zero,
                                                toleranceAfter: .zero)
                        playerModel.scrubState = .scrubContinues(videoCurrentTime)
                        dismissTask?.cancel()
                    default:
                        return
                    }
                }
            })
            .onChange(of: playerModel.displayTime, { oldValue, newValue in
                videoCurrentTime = playerModel.displayTime
            })
            .onChange(of: playerModel.isPlaying) {
                if !playerModel.isPlaying {
                    isShowingControls = true
                /* if user starts and stops the video multiple times in short period of time
                this will prevent control buttons to unexpectedly disappear due to
                pending tasks */
                dismissTask?.cancel()
            } else {
                dismissAfterDelay()
            }
        }
        .onChange(of: isShowingControls) { oldValue, newValue in
            if playerModel.isPlaying && isShowingControls {
                dismissAfterDelay()
            } else {
                dismissTask?.cancel()
            }
        }
        
    }
    
    /// Hide control buttons after 4.8 s
    func dismissAfterDelay() {
        dismissTask = Task {
            do {
                try await Task.sleep(for: .seconds(4.8))
                withAnimation(.easeOut(duration: 0.3)) {
                    isShowingControls = false
                }
            } catch is CancellationError {
                print("Task was cancelled: => ")
            } catch {
                print("Error: => \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    InlineControlsView(isShowingControls: .constant(true), sliderWidth: 400)
}
