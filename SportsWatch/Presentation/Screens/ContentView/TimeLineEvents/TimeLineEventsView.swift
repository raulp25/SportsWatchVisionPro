//
//  TimeLineView.swift
//  SportsWatch
//
//  Created by Raul Pena on 01/02/24.
//

import SwiftUI

struct TimeLineEventsView: View {
    let timeLineEvents: [TimeLineEvent]
    let maxWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .center){
            ForEach(timeLineEvents) { event in
                if event.type == .goal {
                    TimeLineEventView(event: event)
                        .contentShape(.hoverEffect, .rect(cornerRadius: 12))
                        .hoverEffect()
                } else {
                    TimeLineEventView(event: event)
                }
            }
        }
        .frame(maxWidth: maxWidth)
        .padding(.horizontal, 30)
        .padding(.vertical, 40)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    TimeLineEventsView(timeLineEvents: DeveloperPreview.shared.timeLineEvents, maxWidth: 700)
}
