//
//  TeamView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

enum OrientationType {
    case vertical, horizontal
}

struct TeamView: View {
    let team: Team
    var isVisitantTeam: Bool = false
    let orientation: OrientationType
    
    var body: some View {
        if orientation == .vertical {
            VStack(alignment: .center, spacing: 20) {
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
                
                Text(team.name)
            }
        } else if orientation == .horizontal {
                if isVisitantTeam {
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
                        
                        Text(team.name)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                } else if !isVisitantTeam {
                    HStack(alignment: .center, spacing: 10) {
                        Text(team.name)
                        
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
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    TeamView(team: DeveloperPreview.shared.matchInfo.localTeam, orientation: .vertical)
}
