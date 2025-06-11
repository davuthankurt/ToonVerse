//
//  DownloadButtonView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 4.06.2025.
//

import SwiftUI

struct DownloadButtonView: View {
    @Binding var image: UIImage
    @Binding var isDownloadButtonPressed: Bool
    @State var animationAmount = 1.0
    @Binding var buttonState: ButtonState
    @Binding var isFramePopupActive: Bool
    
    var body: some View {
        Button(action: downloadAction) {
            Image(systemName: "square.and.arrow.down")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding()
                .background(Color.myBackground)
                .clipShape(.circle)
        }
        .overlay {
            waveAnimation
        }
    }

    private var waveAnimation: some View {
        Circle()
            .stroke(buttonState.color)
            .scaleEffect(animationAmount)
            .opacity(isDownloadButtonPressed ? 2 - animationAmount : 0)
            .overlay {
                Circle()
                    .stroke(buttonState.color)
                    .scaleEffect(animationAmount - 0.3)
                    .opacity(isDownloadButtonPressed ? 2 - animationAmount : 0)
            }
    }

    private func downloadAction() {
        isDownloadButtonPressed = true
        animationAmount = 1.0
        withAnimation(.easeInOut(duration: 1)) {
            animationAmount = 2.0
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
