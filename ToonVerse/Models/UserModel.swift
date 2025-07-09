//
//  UserModel.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 22.06.2025.
//

import Foundation
import RevenueCat

class UserModel: ObservableObject {
    @Published var isSubscriptionActive = false
    
    init() {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if customerInfo?.entitlements.all["Pro"]?.isActive == true {
                // User is "premium"
                self.isSubscriptionActive = true
            }
        }
    }
}
