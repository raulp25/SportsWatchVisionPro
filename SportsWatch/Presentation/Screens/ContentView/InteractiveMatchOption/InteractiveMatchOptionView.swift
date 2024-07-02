//
//  InteractiveMatchOptionView.swift
//  SportsWatch
//
//  Created by Raul Pena on 31/01/24.
//

import SwiftUI

struct InteractiveMatchOptionView: View {
    let interactiveMatchOption: InteractiveMatchOption
    @Environment(SpaceDestinationsModel.self) private var spaceDestinationsModel
    @Binding var isPresentingSpace: Bool
    
    @State private var currentSpaceDestination: SpaceDestination?
    @State private var showCloseBtn = false
    private var isSameSpaceDestinationItem: Bool {
        currentSpaceDestination == spaceDestinationsModel.currenSpacetDestination
    }
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: interactiveMatchOption.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Text(interactiveMatchOption.title)
                    .font(.title)
            }
            .padding(.bottom, 7)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let subscriptionDetails = interactiveMatchOption.subscriptionDetails {
                ZStack {
                    Image(interactiveMatchOption.imageUrl)
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            Color.black.opacity(0.6)
                        }
                    VStack(alignment: .center, spacing: 8) {
                        if !showCloseBtn {
                            if let imageIcon = subscriptionDetails.icon {
                                Image(systemName: imageIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                            }
                            if let caption = subscriptionDetails.caption {
                                Text(caption)
                                    .font(.title)
                                    .frame(maxWidth: 420)
                                    .multilineTextAlignment(.center)
                            }
                            if let buttonText = subscriptionDetails.buttonText {
                                Text(buttonText)
                                    .font(.title)
                                    .frame(width: 220, height: 55)
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    
                            }
                        } else {
                            Text("Close Immersive Space")
                                .font(.title)
                                .frame(width: 320, height: 55)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
                .frame(height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                ZStack {
                    Image(interactiveMatchOption.imageUrl)
                        .resizable()
                        .scaledToFill()
                    if let imageIcon = interactiveMatchOption.imageIcon {
                        Image(systemName: imageIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                    }
                }
                .frame(height: 210)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.horizontal, 15)
        .frame(width: 500, height: 300)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            switch interactiveMatchOption.type {
            case .immersive:
                self.currentSpaceDestination = interactiveMatchOption.immersiveSpace
            case .threeSixtyView:
                self.currentSpaceDestination = interactiveMatchOption.threeSixtyVideo
            default: print("-")
            }
        }
        // Control the show / hide state of Immersive Spaces and Modal View (popup)
        .onTapGesture {
            if  interactiveMatchOption.type == .popup
                // || interactiveMatchOption.type == .volume
            {
                openWindow(id: "SecondWindow", value: interactiveMatchOption.popup!)
                return
            }
            
            Task {
                if isPresentingSpace && isSameSpaceDestinationItem {
                    await dismissImmersiveSpace()
                    isPresentingSpace = false
                    spaceDestinationsModel.currenSpacetDestination = nil
                    showCloseBtn = false
                    return
                }
                
                switch interactiveMatchOption.type {
                case .immersive:
                        await loadImmersiveSpace(with: interactiveMatchOption.immersiveSpace)
                case .threeSixtyView:
                    await loadImmersiveSpace(with: interactiveMatchOption.threeSixtyVideo)
                case .volume:
                    print("Open Volume and load 3D Model: =>")
                case .popup:
                    print("Do nothing")
                }
            }
        }
        // Sometimes this wont work correctly, might be a SwiftUI or VisionOS or M1 chip bug.. who knows.
        .onChange(of: spaceDestinationsModel.currenSpacetDestination) { _, spaceDestination in
            if isSameSpaceDestinationItem {
                showCloseBtn = true
            } else {
                showCloseBtn = false
            }
        }
    }
    
    private func loadImmersiveSpace(with spaceDestination: SpaceDestination?) async {
        guard spaceDestination != nil && 
              spaceDestinationsModel.currenSpacetDestination == nil
        else {
            replaceCurrentSpaceDestination(with: spaceDestination)
            return
        }
        
        switch await openImmersiveSpace(value: spaceDestination!) {
        case .opened:
            isPresentingSpace = true
            spaceDestinationsModel.currenSpacetDestination = spaceDestination
        default: isPresentingSpace = false
        }
    }
    
    private func replaceCurrentSpaceDestination(with spaceDestination: SpaceDestination?) {
        guard spaceDestination != nil else { return }
        spaceDestinationsModel.currenSpacetDestination = spaceDestination
    }
}

#Preview {
    InteractiveMatchOptionView(interactiveMatchOption: DeveloperPreview.shared.interactiveMatchOptionWithoutSubscription, isPresentingSpace: .constant(false))
}
