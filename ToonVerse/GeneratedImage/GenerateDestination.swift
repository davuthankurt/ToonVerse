//
//  GenerateDestination.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 21.06.2025.
//

import NavigatorUI
import SwiftUI

enum GenerateDestination {
    case paywallScreen
}

extension GenerateDestination: NavigationDestination {
    public var body: some View {
        switch self {
        case .paywallScreen:
            PaywallScreen()
        }
    }
}
