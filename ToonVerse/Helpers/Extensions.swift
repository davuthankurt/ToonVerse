//
//  Extensions.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 17.06.2025.
//

import Foundation
import RevenueCat
import StoreKit

/* Some methods to make displaying subscription terms easier */

extension Package {
    var terms: String {
        if let intro = self.storeProduct.introductoryDiscount {
            if intro.price == 0 {
                return "\(intro.subscriptionPeriod.periodTitle) free trial"
            } else {
                return "\(self.localizedIntroductoryPriceString!) for \(intro.subscriptionPeriod.periodTitle)"
            }
        } else {
            return "Unlocks Premium"
        }
    }
}

extension RevenueCat.SubscriptionPeriod {
    var durationTitle: String {
        switch self.unit {
        case .day: return "day"
        case .week: return "Weekly"
        case .month: return "month"
        case .year: return "Annual"
        @unknown default: return "Unknown"
        }
    }
    
    var periodTitle: String {
        let periodString = "\(self.value) \(self.durationTitle)"
        let pluralized = self.value > 1 ?  periodString + "s" : periodString
        return pluralized
    }
}
