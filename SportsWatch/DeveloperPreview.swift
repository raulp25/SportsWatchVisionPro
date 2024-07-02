//
//  DeveloperPreview.swift
//  SportsWatch
//
//  Created by Raul Pena on 30/01/24.
//

import Foundation
import AVKit
import SwiftUI
class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    var video: Video!
    var videoMock: Video!
    var matchInfo: MatchInfo!
    var matchInfo2: MatchInfo!
    var matchInfo3: MatchInfo!
    var matchInfo4: MatchInfo!
    var matchesArr: [MatchInfo]!
    var matchesDict: [String: MatchInfo]!
    var teams: [Team]!
    var interactiveMatchOptions: [InteractiveMatchOption]!
    var timeLineEvents: [TimeLineEvent]!
    var players: [TeamPlayer] = []
    var submenus: [SubMenu] = []
    
    let realMadrid: Team                = .init(name: "Real Madrid", imageUrl: "realmadrid-logo", tablePosition: 1, gamesPlayed: 12, gamesWin: 12, gamesLost: 0, players: [])
    private let atleticoDeMadrid: Team  = .init(name: "Atletico de Madrid", imageUrl: "atletico-logo", tablePosition: 4, gamesPlayed: 12, gamesWin: 10, gamesLost: 2, players: [])
    private let barcelona: Team         = .init(name: "Barcelona FC", imageUrl: "barcelona-logo", tablePosition: 3, gamesPlayed: 12, gamesWin: 11, gamesLost: 1, players: [])
    private let bayernMunchen: Team     = .init(name: "Bayern Munchen", imageUrl: "bayern-logo", tablePosition: 2, gamesPlayed: 12, gamesWin: 11, gamesLost: 1, players: [])
    private let borussiaDortmund: Team  = .init(name: "Borussia Dortmund", imageUrl: "borussia-logo", tablePosition: 6, gamesPlayed: 12, gamesWin: 3, gamesLost: 9, players: [])
    let manchesterUnited: Team          = .init(name: "Manchester United", imageUrl: "manchester-logo", tablePosition: 8, gamesPlayed: 4, gamesWin: 8, gamesLost: 10, players: [])
    private let arsenal: Team           = .init(name: "Arsenal FC", imageUrl: "arsenal-logo", tablePosition: 6, gamesPlayed: 12, gamesWin: 6, gamesLost: 2, players: [])
    private let parisSaintGermain: Team = .init(name: "Paris Saint Germain", imageUrl: "paris-logo", tablePosition: 7, gamesPlayed: 12, gamesWin: 7, gamesLost: 2, players: [])
    private let matchStats: [MatchInfoStat] = generateMatchStats()
    
    // Subscriptions generic options
    let interactiveMatchOptionWithoutSubscription: InteractiveMatchOption = .init(icon: "play.circle", title: "Try 360 View", imageUrl: "360view", imageIcon: "arrow.triangle.2.circlepath", subscriptionDetails: nil, type: .immersive, immersiveSpace: .init(url: "stadium1-scene"), threeSixtyVideo: nil, volume: nil, popup: nil)
    let interactiveMatchOptionWithSubscription: InteractiveMatchOption = .init(icon: "play.circle", title: "Try 360 View", imageUrl: "360view", imageIcon: "arrow.triangle.2.circlepath", subscriptionDetails: .init(icon: "lock", caption: "Convert your room into the Bernabeu locker room", buttonText: "Become Pro"), type: .immersive, immersiveSpace: .init(url: "stadium1-scene"), threeSixtyVideo: nil, volume: nil, popup: nil)
    
    // No subscription options
    let interactiveMatchOptionBecomeSupporter: InteractiveMatchOption = .init(icon: "play.circle", title: "Become Supporter", imageUrl: "becomesupporter", imageIcon: nil, subscriptionDetails: nil, type: .popup, immersiveSpace: nil, threeSixtyVideo: nil, volume: nil, popup: .init(title: "Become a PRO Member", caption: "Try all features now", buttonText: "Buy now"))
    let interactiveMatchOptionPopularView: InteractiveMatchOption = .init(icon: "play.circle", title: "Popular View", imageUrl: "popularview", imageIcon: "eye.fill", subscriptionDetails: nil, type: .immersive, immersiveSpace: .init(url: "stadium3-scene"), threeSixtyVideo: nil, volume: nil, popup: nil)
    let interactiveMatchOption360View: InteractiveMatchOption = .init(icon: "play.circle", title: "Try 360 View", imageUrl: "360view", imageIcon: "arrow.triangle.2.circlepath", subscriptionDetails: nil, type: .threeSixtyView, immersiveSpace: nil, threeSixtyVideo: .init(url: "stadium2-scene"), volume: nil, popup: nil)
    // Subscription options
    let interactiveMatchOptionStadiumTour: InteractiveMatchOption = .init(icon: "play.circle", title: "Stadium Tour", imageUrl: "stadiumtour", imageIcon: "arrow.triangle.2.circlepath", subscriptionDetails: .init(icon: "lock", caption: "From Madrid visit the Bernabeu with a virtual Tour", buttonText: "Become Pro"), type: .immersive, immersiveSpace: .init(url: "stadium1-scene"), threeSixtyVideo: nil, volume: nil, popup: nil)
    let interactiveMatchOptionLockerRoom: InteractiveMatchOption = .init(icon: "play.circle", title: "Locker Room", imageUrl: "lockerroom", imageIcon: "arrow.triangle.2.circlepath", subscriptionDetails: .init(icon: "lock", caption: "Convert your room into the Bernabeu locker room", buttonText: "Become Pro"), type: .immersive, immersiveSpace: .init(url: "locker1-scene"), threeSixtyVideo: nil, volume: nil, popup: nil)
    
    let spaceDestinationStadium: SpaceDestination = .init(url: "stadium1-scene")
    
    // Time line events
    let timeLineSwitchPlayerEvent: TimeLineEvent = .init(type: .switchPlayer, 
                                                         timeLineCardShownEvent: nil,
                                                         timeLineGoalEvent: nil,
                                                         timeLineSwitchPlayerEvent: .init(data: .init(playerName: "Jude Bellingham",
                                                                                                      minute: 44,
                                                                                                      position: "Midfielder",
                                                                                                      teamImageUrl: "realmadrid-logo"),
                                                         entryPlayerData: .init(playerName: "Tony Kroos",
                                                                                minute: 44,
                                                                                position: "Midfielder",
                                                                                teamImageUrl: "real-madrid")))
//    Ángel Correa
    let timeLineCardShownEventFive: TimeLineEvent = .init(type: .yellowCard,
                                                          timeLineCardShownEvent: .init(data: .init(playerName: "Arda Güler",
                                                                                                    minute: 87,
                                                                                                    position: "Left Wing",
                                                                                                    teamImageUrl: "realmadrid-logo")),
                                                          timeLineGoalEvent: nil,
                                                          timeLineSwitchPlayerEvent: nil)
    let timeLineGoalEventFour: TimeLineEvent = .init(type: .goal,
                                                     timeLineCardShownEvent: nil,
                                                     timeLineGoalEvent: .init(data: .init(playerName: "Cristiano Ronaldo",
                                                                                          minute: 65,
                                                                                          position: "Striker",
                                                                                          teamImageUrl: "realmadrid-logo"),
                                                                                          previewImageUrl: "cr7-goal",
                                                                                          video: .init(id: 4,
                                                                                                          url: Bundle.main.url(forResource: "cr7chilena-goal", withExtension: "mp4")!,
                                                                                                          title: "CR7 Goal",
                                                                                                          imageName: "realmadrid",
                                                                                                          description: "real madrid match",
                                                                                                          info: .init(releaseYear: "2024",
                                                                                                                      contentRating: "R",
                                                                                                                      duration: "15",
                                                                                                                      genres: ["Champions League"],
                                                                                                                      stars: ["Cristiano Ronaldo"],
                                                                                                                      directors: ["director massa"],
                                                                                                                      writers: ["writer Ghost"]))
                                                     ),
                                                     timeLineSwitchPlayerEvent: nil)
    let timeLineCardShownEventThree: TimeLineEvent = .init(type: .redCard,
                                                           timeLineCardShownEvent: .init(data: .init(playerName: "Antoine Griezmann",
                                                                                                     minute: 40,
                                                                                                     position: "Striker",
                                                                                                     teamImageUrl: "atletico-logo")),
                                                           timeLineGoalEvent: nil,
                                                           timeLineSwitchPlayerEvent: nil)
    let timeLineCardShownEventTwo: TimeLineEvent = .init(type: .yellowCard,
                                                         timeLineCardShownEvent: .init(data: .init(playerName: "Alvaro Morata",
                                                                                                   minute: 32,
                                                                                                   position: "Striker",
                                                                                                   teamImageUrl: "realmadrid-logo")),
                                                         timeLineGoalEvent: nil,
                                                         timeLineSwitchPlayerEvent: nil)
    let timeLineCardShownEventOne: TimeLineEvent = .init(type: .yellowCard,
                                                         timeLineCardShownEvent: .init(data: .init(playerName: "Angel Correa",
                                                                                                   minute: 20,
                                                                                                   position: "Defense",
                                                                                                   teamImageUrl: "atletico-logo")),
                                                         timeLineGoalEvent: nil,
                                                         timeLineSwitchPlayerEvent: nil)
    // Players
    
    let playerDEGEA:     TeamPlayer = .init(name: "DAVID", 
                                            surename: "DE GEA",
                                            number: 1,
                                            imageUrl: "DEGEA",
                                            position: .goalkeeper,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerMALACIA:   TeamPlayer = .init(name: "TYRELL", 
                                            surename: "MALACIA",
                                            number: 12,
                                            imageUrl: "malacia",
                                            position: .defense,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerMARTINEZ:  TeamPlayer = .init(name: "LISANDRO", 
                                            surename: "MARTINEZ",
                                            number: 6,
                                            imageUrl: "martinez",
                                            position: .defense,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerVARANE:    TeamPlayer = .init(name: "RAPHAEL", 
                                            surename: "VARANE",
                                            number: 19,
                                            imageUrl: "varane",
                                            position: .defense,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerDALOT:     TeamPlayer = .init(name: "DIOGO", 
                                            surename: "DALOT",
                                            number: 20,
                                            imageUrl: "dalot",
                                            position: .defense,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerERIKSEN:   TeamPlayer = .init(name: "CHRISTIAN", 
                                            surename: "ERIKSEN",
                                            number: 14,
                                            imageUrl: "eriksen",
                                            position: .midfielder,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerCASEMIRO:  TeamPlayer = .init(name: "CARLOS", 
                                            surename: "CASEMIRO",
                                            number: 18,
                                            imageUrl: "casemiro",
                                            position: .midfielder,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerSANCHO:    TeamPlayer = .init(name: "JADON", 
                                            surename: "SANCHO",
                                            number: 25,
                                            imageUrl: "sancho",
                                            position: .striker,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerFERNANDES: TeamPlayer = .init(name: "BRUNO", 
                                            surename: "FERNANDES",
                                            number: 8,
                                            imageUrl: "fernandes",
                                            position: .striker,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerRASHFORD:  TeamPlayer = .init(name: "MARCUS", 
                                            surename: "RASHFORD",
                                            number: 10,
                                            imageUrl: "rashford",
                                            position: .striker,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    let playerRONALDO:   TeamPlayer = .init(name: "CRISTIANO", 
                                            surename: "RONALDO",
                                            number: 7,
                                            imageUrl: "ronaldo",
                                            position: .striker,
                                            lefStats: [.init(range: 81, acronym: "PAC"), .init(range: 92, acronym: "SHO"), .init(range: 78, acronym: "PAS")],
                                            rightStats: [.init(range: 85, acronym: "DRI"), .init(range: 34, acronym: "DEF"), .init(range: 75, acronym: "PHY")])
    
    
    let championsLeagueSubMenuOption: SubMenu  = .init(title: "CHAMPIONS", caption: "LEAGUE", doubleline: true, backgroundImageUrl: "borussia-logo", iconName: "trophy.fill", type: .football)
    let footballSubMenuOption: SubMenu         = .init(title: "FOOTBALL", caption: "GAMES", doubleline: true, backgroundImageUrl: nil, iconName: "soccerball.circle.inverse", type: .football)
    let nflSubMenuOption: SubMenu              = .init(title: "NFL", caption: "GAMES", doubleline: true, backgroundImageUrl: nil, iconName: "football.fill", type: .mockView)
    let nbaSubMenuOption: SubMenu              = .init(title: "NBA", caption: "GAMES", doubleline: true, backgroundImageUrl: nil, iconName: "basketball.fill", type: .mockView)
    let videoCalibrationSubMenuOption: SubMenu = .init(title: "VIDEO", caption: "CALIBRATION", doubleline: true, backgroundImageUrl: nil, iconName: "video.fill", type: .mockView)
    let accessibilitySubMenuOption: SubMenu    = .init(title: "ACCESSIBILITY", caption: nil, doubleline: false, backgroundImageUrl: nil, iconName: "figure.mixed.cardio", type: .mockView)
    let settingsSubMenuOption: SubMenu         = .init(title: "SETTINGS CONTROLS", caption: nil, doubleline: false, backgroundImageUrl: nil, iconName: "gearshape.fill", type: .mockView)
    
  
    private init() {
       loadData()
    }
    
    func loadData() {
        video = .init(id: 3,
                      url: Bundle.main.url(forResource: "realmadrid", withExtension: "mp4")!,
                      title: "RealMadird vs Atletico de Madrid",
                      imageName: "realmadrid",
                      description: "real madrid match",
                      info: .init(releaseYear: "2024",
                                  contentRating: "R",
                                  duration: "322",
                                  genres: ["Champions League"],
                                  stars: ["Cristiano Ronaldo"],
                                  directors: ["director locki"],
                                  writers: ["writer aley"]))
        
        videoMock = .init(id: 4,
                         url: Bundle.main.url(forResource: "cherryblossom", withExtension: "mp4")!,
                         title: "Antonio.609 - I Love U/F U",
                         imageName: "cherry",
                         description: "song",
                         info: .init(releaseYear: "2024",
                                     contentRating: "R",
                                     duration: "60",
                                     genres: ["Champions League"],
                                     stars: ["Christian Von Koeniggsegg"],
                                     directors: ["director "],
                                     writers: ["writer bass"]))
        
        matchInfo = .init(visitantTeam: self.atleticoDeMadrid,
                          localTeam: self.realMadrid,
                          visitantTeamScore: 2,
                          localTeamScore: 3,
                          stats: self.matchStats)
        
        matchInfo2 = .init(visitantTeam: self.barcelona,
                           localTeam: self.bayernMunchen,
                           visitantTeamScore: 8,
                           localTeamScore: 2,
                           stats: self.matchStats)
        
        matchInfo3 = .init(visitantTeam: self.borussiaDortmund,
                           localTeam: self.manchesterUnited,
                           visitantTeamScore: 2,
                           localTeamScore: 1,
                           stats: self.matchStats)
        
        matchInfo4 = .init(visitantTeam: self.arsenal,
                           localTeam: self.parisSaintGermain,
                           visitantTeamScore: 0,
                           localTeamScore: 3,
                           stats: self.matchStats)
        
        matchesDict = [
            "matchInfo": matchInfo,
            "matchInfo2": matchInfo2,
            "matchInfo3": matchInfo3,
            "matchesInfo4": matchInfo4
        ]
        
        matchesArr = matchesDict.map { $1 } // $1 as (_, value) (matchInfo)
        
        teams = [
            realMadrid,
            atleticoDeMadrid,
            barcelona,
            bayernMunchen,
            borussiaDortmund,
            manchesterUnited,
            arsenal,
            parisSaintGermain
        ].sorted(by: { $0.tablePosition < $1.tablePosition })
        
        interactiveMatchOptions = [
            interactiveMatchOptionBecomeSupporter,
            interactiveMatchOptionPopularView,
            interactiveMatchOption360View,
            interactiveMatchOptionStadiumTour,
            interactiveMatchOptionLockerRoom
        ]
        
        timeLineEvents = [
            timeLineCardShownEventFive,
            timeLineGoalEventFour,
            timeLineCardShownEventThree,
            timeLineCardShownEventTwo,
            timeLineCardShownEventOne
        ]
        
        players = [
            playerDEGEA,
            playerMALACIA,
            playerMARTINEZ,
            playerVARANE,
            playerDALOT,
            playerERIKSEN,
            playerCASEMIRO,
            playerSANCHO,
            playerFERNANDES,
            playerRASHFORD,
            playerRONALDO
        ]
        
        submenus = [
            championsLeagueSubMenuOption,
            footballSubMenuOption,
            nflSubMenuOption,
            nbaSubMenuOption,
            videoCalibrationSubMenuOption,
            accessibilitySubMenuOption,
            settingsSubMenuOption
        ]
        
    }
    
    private static func generateMatchStats() -> [MatchInfoStat] {
        var matchStats: [MatchInfoStat] = []
        
        MatchInfoStatType.allCases.forEach { statType in
            switch statType {
            case .goal:
                matchStats.append(.init(type: .goal, caption: "84 - Goal by Morata"))
            case .yellowCard:
                matchStats.append(.init(type: .yellowCard, caption: "32 - Vinicius Jr Yellow Card"))
            case .redCard:
                matchStats.append(.init(type: .redCard, caption: "65 - Nahuel Molina Red Card"))
            case .playerChange:
                matchStats.append(.init(type: .playerChange, caption: "12 - Mario Hernandez change"))
            case .injury:
                matchStats.append(.init(type: .injury, caption: "43 - Atua Girezman Injury"))
            case .suspended:
                matchStats.append(.init(type: .suspended, caption: "75 - Match suspended"))
            case .finished:
                matchStats.append(.init(type: .finished, caption: "90 - Match Finished"))
            }
        }
        
        return matchStats
    }

}
