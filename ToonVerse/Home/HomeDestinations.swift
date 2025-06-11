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
    case paywallScreen
}

extension HomeDestinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .generatedImageView(let image, let filter):
            GeneratedImageView(image: image, selectedFilter: filter)
        case .paywallScreen:
            PaywallScreen()
        }
    }
}
