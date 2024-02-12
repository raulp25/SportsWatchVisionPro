//
//  ModalView.swift
//  SportsWatch
//
//  Created by Raul Pena on 11/02/24.
//

import SwiftUI

struct ModalView: View {
    var popup: Popup
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(spacing: 15){
            Text("SportsWatch")
                .font(.system(size: 65, weight: .bold))
            
            Image("trophy")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
                .padding(.top, 10)
            
            Text("Full year memebership")
                .font(.system(size: 30, weight: .bold))
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
            Text("19.99$")
                .font(.system(size: 30, weight: .bold))
            HStack(alignment: .center, spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("+Service")
                    Text("+Advantages")
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("+Add-ons")
                    Text("+Bonuses")
                }
            }
            .font(.system(size: 18))
            .padding(.top, 10)
            VStack {
                Text(popup.buttonText!)
            }
            .font(.system(size: 20, weight: .bold))
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .frame(maxWidth: 300)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .contentShape(.hoverEffect, .rect(cornerRadius: 25))
            .hoverEffect()
            .padding(.top, 40)
            .onTapGesture { dismissWindow() }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .glassBackgroundEffect(displayMode: .always)
        .background(.ultraThickMaterial)
    }

}

#Preview {
    ModalView(popup: .init(title: "Modal Title", caption: "Modal caption", buttonText: "Accept terms"))
}
