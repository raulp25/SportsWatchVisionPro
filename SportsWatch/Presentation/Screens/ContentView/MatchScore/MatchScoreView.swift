//
//  MatchScore.swift
//  SportsWatch
//
//  Created by Raul Pena on 30/01/24.
//

import SwiftUI

struct MatchScoreView: View {
    
    let matchInfo: MatchInfo
    var maxWidth: CGFloat
    var calcMaxWidth: CGFloat {
        let width = ((maxWidth / 3) - 40)
        return (width <= 0) ? 0 : width
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            HStack(alignment: .top, spacing: 40) {
                VStack(alignment: .center, spacing: 20) {
                    TeamLogo(imageUrl: matchInfo.localTeam.imageUrl)
                    Text(matchInfo.localTeam.name)
                }
                .frame(maxWidth: calcMaxWidth)
                
                HStack(alignment: .center, spacing: 10) {
                    Text(String(matchInfo.localTeamScore))
                    Text("-")
                    Text(String(matchInfo.visitantTeamScore))
                }
                .frame(maxWidth: calcMaxWidth)
                .font(.system(size: 30, weight: .bold))
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .center, spacing: 20) {
                    TeamLogo(imageUrl: matchInfo.visitantTeam.imageUrl)
                    Text(matchInfo.visitantTeam.name)
                }
                .frame(maxWidth: calcMaxWidth)
            }
            
            VStack(alignment: .center, spacing: 10){
                ForEach(matchInfo.stats.prefix(3)) { stat in
                    Text(stat.caption)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: 300)
        .padding()
        .background { Image("rainy-sky").resizable().scaledToFill() }
        .clipShape(RoundedRectangle(cornerRadius: 22))
            
       
    }
}

#Preview {
    MatchScoreView(matchInfo: DeveloperPreview.shared.matchInfo, maxWidth: 700)
}
