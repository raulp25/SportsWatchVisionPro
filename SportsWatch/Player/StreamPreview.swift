//
//  StreamPreview.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI

struct StreamPreview: View {
    let video: Video
    @State private var isPosterVisible = true
    
    var body: some View {
        InlinePlayerView(video: video)
    }
}

#Preview {
    StreamPreview(video: DeveloperPreview.shared.video)
}

