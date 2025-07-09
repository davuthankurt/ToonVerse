//
//  SettingsScreen.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 23.06.2025.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @Environment(\.requestReview) var requestReview
    @Environment(\.navigator) var navigator
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                VStack(alignment: .leading, spacing: proxy.size.height < 700 ? 10 :  16) {
                    settingsTitle
                    settingsImage
                    termsButton
                    policyButton
                    reviewButton
                    paywallButton
                    Spacer()
                }
                .padding()
            }
        }
        .background(.myBackground)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    private var settingsTitle: some View {
        Text("Settings")
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
    }
    
    private var settingsImage: some View {
            ZStack(alignment: .bottom) {
                Image(.semiRealistic)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(.rect(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white, lineWidth: 2)
                    }
                
                Text("ToonStellar - Best AI Image Generator")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                    .multilineTextAlignment(.center)
            }
    }

    private var termsButton: some View {
        Button {
            if let url = URL(string: "https://sites.google.com/view/toonstellar-termsconditions/ana-sayfa") {
                openURL(url)
            }
        } label: {
            Text("Terms")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 12))
    }

    private var policyButton: some View {
        Button {
            if let url = URL(string: "https://sites.google.com/view/toonstellar-privacypolicy/ana-sayfa") {
                openURL(url)
            }
        } label: {
            Text("Privacy")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 12))
    }
    
    private var reviewButton: some View {
        Button {
            requestReview()
        } label: {
            Text("Review ToonStellar")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 12))
    }
    
    private var paywallButton: some View {
        Button {
            navigator.navigate(to: HomeDestinations.paywallScreen, method: .cover)
        } label: {
            Text("Go Premium")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    SettingsScreen()
}
