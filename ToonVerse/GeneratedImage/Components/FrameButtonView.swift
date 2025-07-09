//
//  FrameButtonView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 4.06.2025.
//

import SwiftUI

struct FrameButtonView: View {
    @Binding var isFramePopupActive: Bool
    @Binding var rotationAngle: Double
    @Binding var buttonState: ButtonState
    var body: some View {
        Button {
            withAnimation(.smooth(duration: 0.8)) {
                isFramePopupActive.toggle()
                isFramePopupActive ? (rotationAngle += 720) : (rotationAngle -= 720)
            }
        } label: {
            Image(systemName: "rectangle.3.offgrid")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding()
                .background(.myBackground)
                .clipShape(.circle)
                .rotationEffect(.degrees(rotationAngle))
        }
        .shadow(
            color: buttonState.color,
            radius: isFramePopupActive ? 20 : 5
        )
        .disabled(buttonState != .start)
    }
}
