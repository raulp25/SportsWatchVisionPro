//
//  LeagueGeneralPositionsTableView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct LeagueGeneralPositionsTableView: View {
    
    let teams: [Team]
    let maxWidth: CGFloat
 
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Text("Champions League Table")
                    .padding(.vertical, 20)
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            
            HStack(alignment: .center, spacing: 22.5){
                Text("G")
                Text("W")
                Text("L")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.top)
            
            ForEach(teams) { team in
                TeamGeneralPositionTableView(team: team)
                    .padding(.top, team.tablePosition != 1 ? 10 : 0)
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
    LeagueGeneralPositionsTableView(teams: DeveloperPreview.shared.teams, maxWidth: 1000)
}
