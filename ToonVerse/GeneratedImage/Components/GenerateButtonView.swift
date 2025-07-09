//
//  GenerateButtonView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 4.06.2025.
//

import SwiftUI
import NavigatorUI

struct GenerateButtonView: View {
    @EnvironmentObject var userModel: UserModel
    
    @Binding var buttonState: ButtonState
    @Binding var isFramePopupActive: Bool
    @Binding var size: String?
    @Binding var imageToShow: UIImage
    @Binding var prompt: AIFilter
    var imageToGenerate: UIImage
    var navigator: Navigator?
    
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
                case .processing:
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
}

extension GenerateButtonView {
    private func editImage() async {
        if userModel.isSubscriptionActive {
            await processImage(shouldDecrementCredit: false)
            return
        }
        if getRemainingCredits() > 0 {
            await processImage(shouldDecrementCredit: true)
        } else { 
            navigator?.navigate(to: GenerateDestination.paywallScreen, method: .cover)
        }
    }

    private func processImage(shouldDecrementCredit: Bool) async {
        buttonState = .processing
        let imageSize = size ?? "1024x1024"
        if let finalImage = await AIService().generateImage(imageToGenerate, prompt, imageSize) {
            imageToShow = finalImage
            buttonState = .success
            if shouldDecrementCredit {
                decrementCredit()
            }
        } else {
            buttonState = .failure
        }
        
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        buttonState = .start
    }
    func decrementCredit() {
        let keychain = KeychainWrapper.standard
        let current = keychain.integer(forKey: "com.toonverse.remainingCredits") ?? 0
        if current > 0 {
            keychain.set(current - 1, forKey: "com.toonverse.remainingCredits")
        }
    }
    
    func getRemainingCredits() -> Int {
        return KeychainWrapper.standard.integer(forKey: "com.toonverse.remainingCredits") ?? 0
    }
}
