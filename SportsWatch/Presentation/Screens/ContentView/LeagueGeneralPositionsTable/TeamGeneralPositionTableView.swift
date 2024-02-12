//
//  TeamGeneralPositionTableView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct TeamGeneralPositionTableView: View {
    
    let team: Team
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            HStack(alignment: .center, spacing: 10) {
                HStack {
                    Image(team.imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                .background(.thinMaterial)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                HStack(alignment: .center, spacing: 20) {
                    Text("#")
                    Text(String(team.tablePosition))
                }
                .padding(.leading, 10)
                
                /* Preferred spacer over frame(maxW:.infinity) due to better
                   distribution */
                Spacer()
                Text(team.name)
                    .frame(maxWidth: .infinity)
                Spacer()
                HStack(alignment: .center, spacing: 20) {
                    Text(String(team.gamesPlayed))
                    Text(String(team.gamesWin))
                    Text(String(team.gamesLost))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    TeamGeneralPositionTableView(team: DeveloperPreview.shared.teams[0])
}
