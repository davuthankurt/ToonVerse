//
//  ButtonState.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 27.05.2025.
//

import SwiftUI

enum ButtonState {
    case start
    case processing
    case success
    case failure
    
    var color: Color {
        switch self {
        case .start:
            .myBlue
        case .processing:
            .white
        case .success:
            .green
        case .failure:
            .red
        }
    }
}

struct SpinnerView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .stroke(Color.white.opacity(0.3), lineWidth: 4)
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 4, lineCap: .square))
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            )
            .frame(width: 20, height: 20)
            .onAppear {
                isAnimating = true
            }
    }
}
