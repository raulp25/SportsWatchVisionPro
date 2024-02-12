//
//  KickOffView.swift
//  SportsWatch
//
//  Created by Raul Pena on 05/02/24.
//

import SwiftUI

struct KickOffView: View {
    var body: some View {
            VStack(alignment: .center){
                HStack {
                    Text("KICK OFF")
                        .fontDesign(.rounded)
                        .font(.extraLargeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 107/255, green: 106/255, blue: 173/255))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
                .padding(.leading, 20)

                
                Text("10 February 2024")
                    .fontDesign(.rounded)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(red: 107/255, green: 106/255, blue: 173/255))
                    .padding(.top, 20)
                
                HStack(alignment: .top, spacing: 27) {
                    
                    KickOffTeamView(position: "1ST", imageUrl: DeveloperPreview.shared.manchesterUnited.imageUrl, nameAcronym: "MAN UTD")
                        .padding(.top, 15)
                    
                    Text("13:30")
                        .fontDesign(.rounded)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 107/255, green: 106/255, blue: 173/255))
                    
                    KickOffTeamView(position: "8TH", imageUrl: DeveloperPreview.shared.realMadrid.imageUrl, nameAcronym: "REAL M")
                        .padding(.top, 15)
                }
                .offset(y: -15)
                
                Image("champions-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170)
                    .padding(.top, 30)
                
                Spacer()
            }
            .frame(width: 450, height: 900)
            .background(.white.opacity(0.7))
            .hoverEffect()
            .clipShape(RoundedRectangle(cornerRadius: 0))
        
    }
}

#Preview {
    KickOffView()
}

private struct KickOffTeamView: View {
    let position: String
    let imageUrl: String
    let nameAcronym: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(position)
                .fontDesign(.rounded)
                .font(.extraLargeTitle)
                .foregroundStyle(.secondary)
                .foregroundStyle(Color(red: 199/255, green: 143/255, blue: 46/255))
            TeamLogo(imageUrl: imageUrl, width: 120, height: 120)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { num in
                    HStack(alignment: .center) {
                        Text("\(num == 3 ? "L" : num == 4 ? "D" : "M")")
                            .font(.title2)
                    }
                    .frame(width: 27)
                    .background(num == 3 ? .red : num == 4 ? Color(uiColor: .lightGray) : .green.opacity(0.8))
                }
            }
            
            Text(nameAcronym)
                .fontDesign(.rounded)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color(red: 107/255, green: 106/255, blue: 173/255))
            
        }
    }
}
