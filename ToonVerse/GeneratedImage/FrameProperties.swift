//
//  FrameModel.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 25.05.2025.
//

import Foundation

enum FrameProperties: CaseIterable,Identifiable {
    var id: UUID {
        UUID()
    }
    
    case square
    case portrait
    case landscape
    
    var imageName: String {
        switch self {
        case .square:
            "square"
        case .portrait:
            "rectangle.ratio.3.to.4"
        case .landscape:
            "rectangle.ratio.4.to.3"
        }
    }
    
    var buttonText: String {
        switch self {
        case .square:
            "1:1"
        case .portrait:
            "2:3"
        case .landscape:
            "3:2"
        }
    }
    
    var size: String {
        switch self {
        case .square:
            "1024x1024"
        case .portrait:
            "1024x1536"
        case .landscape:
            "1536x1024"
        }
    }
    
}
