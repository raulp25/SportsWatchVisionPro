//
//  SportsWatchApp.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI

@main
struct SportsWatchApp: App {
    @State private var navigationRouter = NavigationRouter()
    @State private var player = PlayerModel()
    @State private var spaceDestinationsModel = SpaceDestinationsModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(navigationRouter)
                .environment(player)
                .environment(spaceDestinationsModel)
                .ornament(attachmentAnchor: .scene(.top), contentAlignment: .center) {
                    OrnamentView()
                        .environment(navigationRouter)
                        .environment(player)
                        .glassBackgroundEffect(in: .capsule)
                        .padding(.bottom, 200)
                }
        }.windowStyle(.plain).defaultSize(width: 2400, height: 1550)
        
        // View that can represent a user subscription Modal view
        WindowGroup(id: "SecondWindow", for: Popup.self) { $popup in
            if let popup {
                ModalView(popup: popup)
            }
        }.windowStyle(.plain).defaultSize(width: 1000, height: 800)

        ImmersiveSpace(for: SpaceDestination.self) { $spaceDestination in
            if let spaceDestination {
                SpaceDestinationView(spaceDestination)
                    .environment(spaceDestinationsModel)
            }
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}

/* General Notes:
  1.- The “fullscreen” feature, which is triggered by tapping the Image(systemName: "arrow.up.left.and.arrow.down.right") 
      component, only works if you are playing a video on the ContentView(). It doesn’t work with the MockView() since
      it’s just a mock view.
 
  2.- If you want to add functionality to the buttons in InlineControlsView, replace those Button() components with Image() 
      components. Buttons might not work correctly if they are too close to other Button components, or it might be due to
      the simulator or some other reason.
 
  3.- This is a concept app built 100% with the simulator, so any unexpected behavior might be due to this reason or because 
      of me. Flip your coin.
 
  4.- The DeveloperPreview singleton contains all the mock data used for this app.
 
  5.- Views were limited to less than 200 lines of code. Limiting them to less than 100 lines would mean having a lot of files, 
      and this is supposed to be a guide for other developers rather than a real-world product.
 
  ~ Peace.
 */


/* Known bugs:
     1.- If the window is full-sized, the Picker (segmented) that represents Score|Timeline|Line-Up|Stats tabs in ContentView won't recognize clicks made to tabs that are on the right side. You need to resize the window to a smaller size so it recognizes clicks in the right
         direction. Clicks in the left direction in the Picker are always recognized whether the window is fully sized or not.
 
     2.- When switching Immersive spaces on the InteractiveMatchOptionView component, sometimes it won't refresh and call the code inside the current card, and it won't update the close button text in cards that display that button.
 */
