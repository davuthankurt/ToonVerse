//
//  LandingPage.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 2.06.2025.
//

import SwiftUI

struct PaywallScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var colorChange = false
//    Temporary paywall screen
    var body: some View {
        GeometryReader { proxy in
            VStack {
                alignmentStacks(proxy)
                subscriptionSelection("$7.99/weak", "Try all features with full flexibility.\nCancel anytime.")
                subscriptionSelection("$35.99/year", "Save over 50%.\nOne-time payment for a full year of access.")
                
                subscriptionButton
                Spacer()
                policyButton
                
            }
            .background(Color.myBackground.ignoresSafeArea())
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
            }
            headerText
        }
    }
    
    private func backgroundImage(_ proxy: GeometryProxy) -> some View {
        Image(.image7)
            .resizable()
            .scaledToFill()
            .frame(width: proxy.size.width, height: proxy.size.height / 2)
            .clipped()
            .overlay {
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.7),
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
            Text("ToonVerse Pro")
                .font(.title.bold())
                .foregroundStyle(.white)
            
            Text("Gain complete access today")
                .font(.title3)
                .foregroundStyle(.white)
        }
        .padding(.vertical, -10)
    }
    
    private func subscriptionSelection(_ title: String, _ subText: String) -> some View {
        Button {
            
        } label: {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                Text(subText)
                    .font(.subheadline)
                    .foregroundStyle(.myBlue)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.myBackground)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.myBlue.opacity(0.5), lineWidth: 2)
        }
        
        .padding()
    }
    
    private var subscriptionButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Hello World")
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.myBackground)
            .clipShape(Capsule())
            .fontWeight(.bold)
            .padding()
            .shadow(
                color: .myBlue,
                radius: 5
            )
        }
    }
    
    private var policyButton: some View{
        Button {
            
        } label: {
            Text("Privacy")
                .foregroundStyle(.gray)
        }
        .padding()
    }

}

#Preview {
    PaywallScreen()
}
