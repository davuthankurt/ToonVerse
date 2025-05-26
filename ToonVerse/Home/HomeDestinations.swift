//
//  HomeDesti.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 22.05.2025.
//

import NavigatorUI
import SwiftUI

enum HomeDestinations {
    case generatedImageView(UIImage, AIFilter)
}

extension HomeDestinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .generatedImageView(let image, let prompt):
            GeneratedImageView(image: image, prompt: prompt)
        }
    }
}
