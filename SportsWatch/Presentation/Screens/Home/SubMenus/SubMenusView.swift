//
//  SubMenusView.swift
//  SportsWatch
//
//  Created by Raul Pena on 05/02/24.
//

import SwiftUI

struct SubMenusView: View {
    
    let subMenus: [SubMenu]
    let minWidth: CGFloat = 300
    let maxWidth: CGFloat = 800
    
    var body: some View {
        Grid {
            GridRow {
                HStack(spacing: 18) {
                    SubMenuView(subMenuData: DeveloperPreview.shared.championsLeagueSubMenuOption)
                    SubMenuView(subMenuData: DeveloperPreview.shared.footballSubMenuOption)
                    SubMenuView(subMenuData: DeveloperPreview.shared.nflSubMenuOption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            GridRow {
                HStack(spacing: 18) {
                    SubMenuView(subMenuData: DeveloperPreview.shared.nbaSubMenuOption)
                    SubMenuView(subMenuData: DeveloperPreview.shared.videoCalibrationSubMenuOption)
                    SubMenuView(subMenuData: DeveloperPreview.shared.accessibilitySubMenuOption)
                    SubMenuView(subMenuData: DeveloperPreview.shared.settingsSubMenuOption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    SubMenusView(subMenus: DeveloperPreview.shared.submenus)
}


struct SubMenuView: View {
    let subMenuData: SubMenu
    @Environment(NavigationRouter.self) var navigationRouter
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text(subMenuData.title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .italic()
                        .foregroundStyle(Color(red: 86/255, green: 209/255, blue: 98/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if subMenuData.doubleline,
                       let caption = subMenuData.caption
                    {
                        Text(caption)
                            .font(.largeTitle)
                            .fontWeight(.regular)
                            .fontDesign(.rounded)
                            .italic()
                            .foregroundStyle(Color(red: 86/255, green: 209/255, blue: 98/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.leading, 20)
                
                Spacer()
                
                HStack {
                    Image(systemName: subMenuData.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .padding(.trailing, 30)
                        .padding(.bottom, 40)
                        .foregroundStyle(Color(red: 215/255, green: 36/255, blue: 121/255))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if let backgroundImageUrl = subMenuData.backgroundImageUrl {
                    Image(backgroundImageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
            }
        }
        .frame(width: subMenuData.title.contains("CHAMPIONS") ? 818 : 400, height: 320)
        .background(Color(red: 28/255, green: 21/255, blue: 74/255))
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: 0))
        .onTapGesture {
            switch subMenuData.type {
            case .football:
                self.navigationRouter.setOrnamentTab(to: .allMode)
            case .mockView:
                self.navigationRouter.navigateRoute(to: .mockView)
            }
        }
    }
}
