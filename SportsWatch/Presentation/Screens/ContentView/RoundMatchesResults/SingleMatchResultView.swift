//
//  SingleMatchResultView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct SingleMatchResultView: View {
    
    let matchInfo: MatchInfo
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            TeamView(team: matchInfo.localTeam,
                     orientation: .horizontal)
            // using infinity provokes a little bit more overlapping if window gets super small but we dont care in this case
            .frame(maxWidth: .infinity)
            HStack(alignment: .center, spacing: 10) {
                Text(String(matchInfo.localTeamScore))
                Text("-")
                Text(String(matchInfo.visitantTeamScore))
            }
            .frame(maxWidth: 70)
            .font(.system(size: 20, weight: .bold))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            TeamView(team: matchInfo.visitantTeam,
                     isVisitantTeam: true,
                     orientation: .horizontal)
            // using infinity provokes a little bit more overlapping if window gets super small but we dont care in this case
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    SingleMatchResultView(matchInfo: DeveloperPreview.shared.matchInfo)
}
