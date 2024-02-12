//
//  TeamLogo.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct TeamLogo: View {
    let imageUrl: String
    
    let width: CGFloat
    let height: CGFloat
    
    init(imageUrl: String, width: CGFloat = 40, height: CGFloat = 40) {
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
    }
    
    var body: some View {
        HStack {
            Image(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: width / 2))
        }
        .padding()
        .background(.thinMaterial)
        .frame(width: width + 10, height: height + 10)
        .clipShape(RoundedRectangle(cornerRadius: width / 2 + 5))
    }
}

#Preview {
    TeamLogo(imageUrl: "realmadrid")
}
