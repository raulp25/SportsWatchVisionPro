//
//  HomeView.swift
//  SportsWatch
//
//  Created by Raul Pena on 05/02/24.
//

import SwiftUI

struct HomeView: View {
    @Environment(NavigationRouter.self) var navigationRouter
    @Environment(PlayerModel.self) var player
    
    var body: some View {
        NavigationStack {
            // Main Menu
            if navigationRouter.showHome {
                HStack(spacing: 15){
                    KickOffView()
                        .onTapGesture {
                            self.navigationRouter.setOrnamentTab(to: .allMode)
                        }
                    VStack {
                        SubMenusView(subMenus: DeveloperPreview.shared.submenus)
                            .frame(maxWidth: 1700)
                        BannerView()
                            .onTapGesture {
                                self.navigationRouter.navigateRoute(to: .mockView)
                            }
                    }
                    .frame(height: 900)
                }
                .frame(width: 2120)
            }
            
            // Main Player View
            if navigationRouter.showFootball {
                ContentView(video: DeveloperPreview.shared.video)
            }
            
            // Mock View
            if navigationRouter.showMockView {
                MockView(video: DeveloperPreview.shared.videoMock)
            }
        }
    }
}

#Preview {
    HomeView()
}
