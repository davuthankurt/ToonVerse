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
    case filmPoster
    case urbanFashion
    case boxer
    case gladiator
    case gothic
    case superModel
    case space
    case romanStatue
    case tarzan
    case toy
    
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
        case .filmPoster:
            return "Film Poster"
        case .urbanFashion:
            return "Urban Fashion"
        case .boxer:
            return "Boxer"
        case .gladiator:
            return "Gladiator"
        case .gothic:
            return "Gothic"
        case .superModel:
            return "Super Model"
        case .space:
            return "Mars"
        case .romanStatue:
            return "Roman Statue"
        case .tarzan:
            return "Jungle Man"
        case .toy:
            return "Become Toy"
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
        case .filmPoster:
            return .filmPoster
        case .urbanFashion:
            return .urbanFashion
        case .boxer:
            return .boxer
        case .gladiator:
            return .gladiator
        case .gothic:
            return .gothic
        case .superModel:
            return .superModel
        case .space:
            return .space
        case .romanStatue:
            return .romanStatue
        case .tarzan:
            return .tarzan
        case .toy:
            return .toy
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
            return "Make the image colonial portrait style with a frame around."
        case .superhero:
            return "Make the image superhero style"
        case .wildWest:
            return "Make the image wild west style"
        case .cyberpunk:
            return "Make the image cyberpunk style"
        case .gta:
            return "Make the image gta style"
        case .pixels:
            return "Make the image 2d pixel-art game style"
        case .filmPoster:
            return "Make the image film poster style"
        case .urbanFashion:
            return "Make the image gta style"
        case .boxer:
            return "Make the image a boxing scene style"
        case .gladiator:
            return "Make the image gladiator style"
        case .gothic:
            return "Make the image gothic style"
        case .superModel:
            return "Make the image super model style"
        case .space:
            return "Make the photo look like it was taken on Mars"
        case .romanStatue:
            return "Make the image ancient Roman statue style"
        case .tarzan:
            return "Make the image Tarzan jungle style"
        case .toy:
            return "Make the image lego style"
        }
    }
}

extension AIFilter {
    static var defaultFilters: [AIFilter] {
        return [.middleEarth, .popArt, .manga, .portrait, .superhero, .urbanFashion]
    }
    
    static var mustTry: [AIFilter] {
        return [.cartoon, .toy, .gothic, .bubbleHead, .space, .wildWest, .filmPoster]
    }

    static var landscapeFilters: [AIFilter] {
        return [.pixels, .superModel, .tarzan]
    }
    
    static var portraitFilters: [AIFilter] {
        return [.boxer, .cyberpunk, .gta, .gladiator, .romanStatue]
    }
} 
