//
//  SportsWatchApp.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI

@main
struct SportsWatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
