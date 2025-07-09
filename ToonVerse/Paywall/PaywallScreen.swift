//
//  LandingPage.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 2.06.2025.
//

import SwiftUI
import RevenueCat

struct PaywallScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @EnvironmentObject var userModel: UserModel
    @State private var colorChange = false
    @State private var currentOffering: Offering?
    @State private var selectedPackage: Package?

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                alignmentStacks(proxy)
                Spacer()
                Text("Renews automatically. Cancel anytime.")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                if currentOffering != nil {
                    ForEach(currentOffering!.availablePackages) { pkg in
                        subscriptionSelection(pkg)
                            .padding(.horizontal)
                    }
                }
                subscriptionButton
                    .disabled(selectedPackage == nil)
                

                HStack(alignment: .center) {
                    Spacer()
                    termsButton
                    Spacer()
                    policyButton
                    Spacer()
                    restoreButton
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .background(.myBackground)
            .onAppear {
                Purchases.shared.getOfferings { offerings, error in
                    if let offer = offerings?.current, error == nil {
                        currentOffering = offer
                    }
                }
            }
        }
    }
    
    private func alignmentStacks(_ proxy: GeometryProxy) -> some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                backgroundImage(proxy)
                HStack(alignment: .top) {
                    dismissButton
                    Spacer()
                    realImage
                }
                .padding(.vertical)
            }
            headerText
        }
        .padding(.vertical)
    }
    
    private func backgroundImage(_ proxy: GeometryProxy) -> some View {
        let heightRatio = proxy.size.height < 700 ? 0.5 : 0.6
        return Image(.image7)
            .resizable()
            .scaledToFill()
            .frame(width: proxy.size.width, height: proxy.size.height * heightRatio)
            .clipped()
            .overlay {
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.8),
                        .init(color: .myBackground, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
    }
    
    private var realImage: some View {
        Image(.landingOriginal)
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .clipShape(.circle)
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 1)
            }
            .padding()
            .zIndex(1)
    }
    
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .tint(.white)
                .imageScale(.large)
                .padding()
        }
    }

    private var headerText: some View {
        VStack {
            Text("ToonStellar Pro")
                .font(.title.bold())
                .foregroundStyle(.white)
            
            Text("Gain complete access today")
                .font(.title3)
                .foregroundStyle(.white)
        }
        .padding(.vertical, -10)
    }
    
    private func subscriptionSelection(_ pkg: Package) -> some View {
        let isSelected = selectedPackage?.identifier == pkg.identifier
        
        return Button {
            selectedPackage = pkg
        } label: {
            HStack {
                Circle()
                    .stroke(isSelected ? .myBlue : .white.opacity(0.2), lineWidth: 2)
                    .frame(width: 24, height: 24)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.myBlue)
                        }
                    }
                    
                Text(pkg.storeProduct.subscriptionPeriod!.durationTitle)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(pkg.storeProduct.localizedPriceString)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.myBackground)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? .myBlue : .white.opacity(0.2), lineWidth: 2)
        }
        .shadow(color: .myBlue,
                radius: isSelected ? 5 : 0)
    }
    
    private var subscriptionButton: some View {
        Button {
            if let pkg = selectedPackage {
                Purchases.shared.purchase(package: pkg) { transaction, customerInfo, error, userCancelled in
                    if customerInfo?.entitlements.all["Pro"]?.isActive == true {
                        userModel.isSubscriptionActive = true
                        dismiss()
                    }
                }
            }
        } label: {
            Text("Continue")
                .font(.title2.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background(
            Capsule()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 171/255, green: 167/255, blue: 243/255),
                            .myBlue
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                )
            )
        )
        .padding([.horizontal, .top])
    }
    
    private var termsButton: some View {
        Button {
            if let url = URL(string: "https://sites.google.com/view/toonstellar-termsconditions/ana-sayfa") {
                openURL(url)
            }
        } label: {
            Text("Terms")
                .foregroundStyle(.gray)
        }
        .padding()
    }
    
    private var policyButton: some View {
        Button {
            if let url = URL(string: "https://sites.google.com/view/toonstellar-privacypolicy/ana-sayfa") {
                openURL(url)
            }
        } label: {
            Text("Privacy")
                .foregroundStyle(.gray)
        }
        .padding()
    }

    private var restoreButton: some View {
        Button {
            Purchases.shared.restorePurchases { customerInfo, error in
                // ... check customerInfo to see if entitlement is now active
                if customerInfo?.entitlements.all["Pro"]?.isActive == true {
                    userModel.isSubscriptionActive = true
                    dismiss()
                }
            }
        } label: {
            Text("Restore")
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

#Preview {
    var usermodel = UserModel()
    PaywallScreen()
        .environmentObject(usermodel)
}
