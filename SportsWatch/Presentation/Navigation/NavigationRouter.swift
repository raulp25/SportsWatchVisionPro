//
//  NavigationRouter.swift
//  SportsWatch
//
//  Created by Raul Pena on 06/02/24.
//

import Foundation

/// Control the ornament tabs and the in-app routes
@Observable
class NavigationRouter {
    
    var currentOrnamentTab: OrnamentTab = .home
    var currentRoute: Route? = nil
    
    var showHome: Bool {
        currentOrnamentTab == .home && 
        currentRoute == nil
    }
    
    var showFootball: Bool {
        currentRoute == .football
    }
    
    var showMockView: Bool {
        currentRoute == .mockView
    }
    /// Set the selected ornament tab
    func setOrnamentTab(to ornamentTab: OrnamentTab) {
        
        currentOrnamentTab = ornamentTab
        
        if ornamentTab == .home {
            navigateRoute(to: nil)
        } else if ornamentTab == .allMode || ornamentTab == .tvBroadcaste {
            navigateRoute(to: .football)
            
        } else { // In all other cases, automatically redirect to the mock view of the music video 'Cherry Blossom'.
            navigateRoute(to: .mockView)
        }
    }
    /// Navigates to a specific app route
    ///
    /// This doesn't affect the ornament tab
    func navigateRoute(to route: Route?) {
        currentRoute = route
    }
    
    
}

enum OrnamentTab: String, Identifiable, CaseIterable {
/// Only show the video player and hide the other screen UI elements
case tvBroadcaste = "Tv Broadcaster"
/// Show the video player with all the screen UI elements
case allMode = "All Mode"
/// Show home screen
case home = "Home"
/// Show mock screen
case football = "Football"
/// Show mock screen
case nfl = "NFL"
/// Show mock screen
case nba = "NBA"

var id: Self { self }
    
}


enum Route {
    case football, mockView
}
