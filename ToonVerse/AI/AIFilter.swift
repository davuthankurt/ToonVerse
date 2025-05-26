//
//  AIFilters.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 21.05.2025.
//

import SwiftUI


enum AIFilter: CaseIterable, Identifiable {
    case bubbleHead
    case cartoon
    case manga
    case middleEarth
    case popArt
    case portrait
    case superhero
    case wildWest
    case cyberpunk
    case gta
    case pixels

    var id: UUID {
        UUID()
    }

    var title: String {
        switch self {
        case .bubbleHead:
            return "Bubble Head"
        case .cartoon:
            return "3d Cartoon"
        case .manga:
            return "Manga"
        case .middleEarth:
            return "Middle-Earth"
        case .popArt:
            return "Pop-Art"
        case .portrait:
            return "Portrait"
        case .superhero:
            return "Superhero"
        case .wildWest:
            return "Wild-West"
        case .cyberpunk:
            return "Cyberpunk"
        case .gta:
            return "The Game"
        case .pixels:
            return "Pixel-Art"
        }
    }

    var image: ImageResource {
        switch self {
        case .bubbleHead:
            return .politicalSatire
        case .cartoon:
            return .cartoon
        case .manga:
            return .mangaPanel
        case .middleEarth:
            return .fantasyPortrait
        case .popArt:
            return .popArt
        case .portrait:
            return .colonialPortrait
        case .superhero:
            return .comicsSuperhero
        case .wildWest:
            return .wildWest
        case .cyberpunk:
            return .cyberpunk
        case .gta:
            return .gta
        case .pixels:
            return .pixelArt
        }
    }

    var prompt: String {
        switch self {
        case .bubbleHead:
            return "Make the image bubble head style"
        case .cartoon:
            return "Make the image 3d cartoon style"
        case .manga:
            return "Make the image manga style"
        case .middleEarth:
            return "Make the image middle earth style"
        case .popArt:
            return "Make the image pop art style"
        case .portrait:
            return "Make the image colonial portrait style"
        case .superhero:
            return "Make the image comics superhero style"
        case .wildWest:
            return "Make the image wild west style"
        case .cyberpunk:
            return "Make the image cyberpunk style"
        case .gta:
            return "Make the image gta style"
        case .pixels:
            return "Make the image 2d pixel-art game style"
        }
    }
    
    
}
