//
//  TimeLineEvent.swift
//  SportsWatch
//
//  Created by Raul Pena on 01/02/24.
//

import SwiftUI

struct TimeLineEventView: View {
    let event: TimeLineEvent
    @Environment(PlayerModel.self) var player
    
    @State private var height: CGFloat = 0
    @State private var extendHeight = false
    
    var body: some View {
        HStack(alignment: .center) {
            createEventView(event: event)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal, 20)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            // goal type events extend the view with animation
            if event.type == .goal {
                extendHeight.toggle()
                if extendHeight {
                    withAnimation(.smooth) {
                        height = 250
                    }
                } else {
                    height = 0
                }
            }
        }
    }
    
    // This can be set on different Views but this is ok for now.
    @ViewBuilder
    func createEventView(event: TimeLineEvent) -> some View {
        switch event.type {
        case .yellowCard, .redCard:
            if let event = event.timeLineCardShownEvent {
                HStack(spacing: 50){
                    VStack(alignment: .leading, spacing: 2) {
                        ZStack {
                            Color(uiColor: self.event.type == .yellowCard ? .yellow : .red)
                        }
                        .frame(width: 30, height: 40)
                        .border(.white, width: 2)
                        Text("\(String(event.data.minute))`")
                            .font(.title2)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(event.data.playerName)
                            .font(.title)
                        Text(event.data.position)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    TeamLogo(imageUrl: event.data.teamImageUrl)
                }
            }
        case .goal:
            if let event = event.timeLineGoalEvent {
                VStack {
                    HStack {
                        HStack(spacing: 50){
                            VStack(alignment: .leading, spacing: 2) {
                                Image(systemName: "soccerball")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                
                                Text("\(String(event.data.minute))`")
                                    .font(.title2)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(event.data.playerName)
                                    .font(.title)
                                Text(event.data.position)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            TeamLogo(imageUrl: event.data.teamImageUrl)
                        }
                    }
                    // Use height prop to dinamically show/hide the goal's preview image
                    ZStack {
                        Image(event.previewImageUrl)
                            .resizable()
                            .scaledToFill()
                            .overlay { Color(.black.opacity(0.3)) }
                        
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                    }
                    .frame(maxWidth: .infinity, maxHeight: height)
                    .opacity(height > 0 ? 1 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .onTapGesture {
                        player.loadVideo(event.video)
                        player.isPlayingAlternativeMediaOnMatch = true
                        if player.shouldAutoPlay {
                            player.wasPlaying = true
                            player.play()
                        }
                    }
                }
            }
            
        case .switchPlayer:
            if let event = event.timeLineSwitchPlayerEvent {
                VStack(spacing: 35) {
                    HStack {
                        HStack(spacing: 50){
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(String(event.data.minute))`")
                                    .font(.title2)
                                
                                ZStack {
                                    Image(systemName: "triangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15)
                                        .foregroundStyle(.green)
                                }
                                .frame(width: 40, height: 30)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 7))
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(event.entryPlayerData.playerName)
                                    .font(.title)
                                Text(event.entryPlayerData.position)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack {
                            TeamLogo(imageUrl: event.data.teamImageUrl)
                        }
                    }
                    
                    HStack(spacing: 50){
                        ZStack {
                            Image(systemName: "triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                                .foregroundStyle(.red)
                                .rotationEffect(.degrees(180))
                        }
                        .frame(width: 40, height: 30)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .padding(.top, 5)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(event.data.playerName)
                                .font(.title)
                            Text(event.data.position)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        case .matchEnded:
            Text("Match ended")
        }
    }
}

#Preview {
    TimeLineEventView(event: DeveloperPreview.shared.timeLineCardShownEventThree)
}
