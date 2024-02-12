//
//  BannerView.swift
//  SportsWatch
//
//  Created by Raul Pena on 06/02/24.
//

import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack {
            HStack {
                Image("hat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
            }
            .padding(.trailing, 900)
            
            HStack(alignment: .center, spacing: 10) {
                Image("origin-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
                
                VStack(spacing: 15) {
                    Text("Origin")
                        .fontWeight(.bold)
                    Text("access")
                        .fontWeight(.regular)
                }
            }
            .padding(.leading, 580)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("SAVE WITH ORIGIN ACCESS")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("-10% in FIFA Points this season by joining Origin Access")
                    .font(.title)
                    .fontWeight(.regular)
                    .frame(maxWidth: 500, alignment: .leading)
            }
        }
        .frame(width: 1655, height: 245, alignment: .center)
        .foregroundStyle(Color(red: 173/255, green: 175/255, blue: 181/255))
        .background(Color(red: 28/255, green: 28/255, blue: 28/255))
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: 0))
    }
}

#Preview {
    BannerView()
}
