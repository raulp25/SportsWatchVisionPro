//
//  RoundMatchesResultsView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct RoundMatchesResultsView: View {
    
    let matches: [MatchInfo]
    let maxWidth: CGFloat
    
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Text("Matches Results")
                    .padding(.vertical, 20)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            
            ForEach(matches) { match in
                SingleMatchResultView(matchInfo: match)
                    .padding(.top, 10)
            }
        }
        .frame(maxWidth: maxWidth)
        .padding(.horizontal, 70)
        .padding(.vertical, 40)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

#Preview {
    RoundMatchesResultsView(matches: DeveloperPreview.shared.matchesArr, maxWidth: 700)
}
