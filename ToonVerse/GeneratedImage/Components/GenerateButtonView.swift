//
//  GenerateButtonView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 4.06.2025.
//

import SwiftUI

struct GenerateButtonView: View {
    
    @Binding var buttonState: ButtonState
    @Binding var isFramePopupActive: Bool
    @Binding var size: String?
    
    var body: some View {
        Button {
            Task {
                await editImage()
            }
        } label: {
            HStack {
                switch buttonState {
                case .start:
                    icon("play.circle")
                    text("Generate", font: .title)
                case .proccessing:
                    SpinnerView()
                    text("Generating Image")
                case .success:
                    icon("checkmark.circle")
                    text("Image Generated")
                case .failure:
                    icon("xmark.circle")
                    text("Request Failed")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.myBackground)
            .clipShape(Capsule())
            .fontWeight(.bold)
        }
    }

    private func icon(_ name: String) -> some View {
        Image(systemName: name)
            .tint(.white)
            .foregroundStyle(.white)
            .imageScale(.large)
    }

    private func text(_ value: String, font: Font = .headline) -> some View {
        Text(value)
            .foregroundStyle(.white)
            .font(font)
    }
    
    private func editImage() async {
        buttonState = .proccessing
        let imageSize = size ?? "1024x1024"
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        buttonState = .failure
//        if let finalImage = await AIService().generateImage(image, prompt, imageSize) {
//            image = finalImage
//            buttonState = .success
//        } else {
//            buttonState = .failure
//        }
        
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        buttonState = .start
    }

}
