//
//  HeaderView.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import SwiftUI

struct HeaderView: View {
    @Binding var searchText: String
    @Environment(NavigationRouter.self) var navigationRouter
    @Environment(PlayerModel.self) private var player
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
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
                Task {
                    await self.dismissImmersiveSpace()
                    self.player.reset()
                    self.navigationRouter.setOrnamentTab(to: .home)
                }
            }
            HStack(alignment: .center, spacing: 12) {
                Button {
                    
                } label: {
                    Image(systemName: "mic.fill")
                        .scaledToFit()
                        .contentShape(.interaction, .rect)
                        .contentShape(.hoverEffect, .rect(cornerRadius: 0))
                        .padding(5)
                        .onTapGesture { }
                    
                }
                .buttonStyle(.plain)
                .frame(maxWidth: 50)
                
                TextField("Search", text: $searchText)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .glassBackgroundEffect()
            .presentationCornerRadius(12)
            .padding(.leading, 80)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "c.square")
                    .scaledToFit()
            }
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .scaledToFit()
            }
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .scaledToFit()
            }
            Button {
                
            } label: {
                Image(systemName: "hazardsign.fill")
                    .scaledToFit()
            }
        }
    }
}

#Preview {
    HeaderView(searchText: .constant("430-16M"))
}
