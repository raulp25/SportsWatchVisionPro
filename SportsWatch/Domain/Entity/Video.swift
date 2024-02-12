//
//  Video.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import Foundation
import UIKit

struct Video: Identifiable, Hashable, Codable {
    let id: Int
    /// The URL of the video, which can be local or remote.
    let url: URL
    /// The title of the video.
    let title: String
    /// The base image name.
    let imageName: String
    /// The description of the video.
    let description: String
    /// The name of the video's portrait image.
    var portraitImageName: String { "\(imageName)" }
    /// The name of the video's landscape image.
    var landscapeImageName: String { "\(imageName)" }
    /// The data for the landscape image to create a metadata item to display in the Info panel.
    var imageData: Data {
        UIImage(named: landscapeImageName)?.pngData() ?? Data()
    }
    /// Detailed information about the video like its stars and content rating.
    let info: Info
    
    /// An object that provides detailed information for a video.
    struct Info: Hashable, Codable {
        var releaseYear: String
        var contentRating: String
        var duration: String
        var genres: [String]
        var stars: [String]
        var directors: [String]
        var writers: [String]
        
        var releaseDate: Date {
            var components = DateComponents()
            components.year = Int(releaseYear)
            let calendar = Calendar(identifier: .gregorian)
            return calendar.date(from: components)!
        }
    }
}

