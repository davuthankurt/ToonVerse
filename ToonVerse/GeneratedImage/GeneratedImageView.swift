//
//  GeneratedImageView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 21.05.2025.
//

import SwiftUI


struct GeneratedImageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var image: UIImage
    var prompt: AIFilter
    @State private var size: String?
    
    @State private var isFramePopupActive = false
    @State private var rotationAngle = 0.0
    @State private var animationAmount = 1.0
    @State private var isGlowAnimationActive = false
    @State private var selectedFrame: FrameProperties?
    @State private var buttonState: ButtonState = .start
    @State private var isDownloadButtonPressed = false
}

extension GeneratedImageView {
    var body: some View {
        ZStack {
            Color.myBackground.ignoresSafeArea()
            if isFramePopupActive {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.8)) {
                            isFramePopupActive = false
                            rotationAngle -= 720
                        }
                    }
                panelView
            }
            generationView
        }
    }
    
    private var panelView: some View {
        VStack {
            panelText
            panelStack
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.myBackground)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .transition(.scale.animation(.smooth))
        .zIndex(1)
    }
    
    private var panelText: some View {
        Text("Chose the frame you want.")
            .foregroundStyle(.white)
            .font(.title2)
            .padding()
    }
    
    private var panelStack: some View {
        HStack(alignment: .bottom) {
            ForEach(FrameProperties.allCases) { frame in
                sizeButton(frame: frame, isSelected: selectedFrame == frame)
            }
        }
    }
    
    private var generationView: some View {
        VStack {
            viewImage(image)
            Spacer()
            buttonStack
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private func viewImage(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 16))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .opacity(isFramePopupActive ? 0.5 : 1.0)
    }
    
    
    private var buttonStack: some View {
        HStack {
            Group {
                downloadButton
                generateButton
            }
            .shadow(
                color: buttonState.color,
                radius: 5
            )
            .disabled(isFramePopupActive)
            .opacity(isFramePopupActive ? 0.5 : 1.0)
            
            frameButton
        }
        .disabled(buttonState != .start)
        .animation(.linear, value: buttonState)
    }
    
    private var downloadButton: some View {
        Button(action: downloadAction) {
            Image(systemName: "square.and.arrow.down")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding()
                .background(.myBackground)
                .clipShape(.circle)
        }
        .overlay {
            isFramePopupActive ? nil : waveAnimation
        }
        .padding(.leading)
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
    
    private var generateButton: some View {
        Button {
            Task {
                await editImage()
            }
        } label: {
                generateButtonStack
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.myBackground)
        .clipShape(.capsule)
        .fontWeight(.bold)
        .padding()
    }

    private var generateButtonStack: some View {
        HStack {
            switch buttonState {
            case .start:
                generateButtonImage("play.circle")
                Text("Generate")
                    .foregroundStyle(.white)
                    .font(.title)
            case .proccessing:
                SpinnerView()
                generateButtonText("Generating Image")
            case .failure:
                generateButtonImage("xmark.circle")
                generateButtonText("Request Failed")
            case .success:
                generateButtonImage("checkmark.circle")
                generateButtonText("Image Generated")
            }
        }
    }
    
    private func generateButtonImage(_ str: String) -> some View {
        Image(systemName: str)
            .tint(.white)
            .foregroundStyle(.white)
            .imageScale(.large)
    }
    
    private func generateButtonText(_ str: String) -> some View {
        Text(str)
            .foregroundStyle(.white)
            .font(.headline)
    }
    
    private var frameButton: some View {
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
        .padding(.trailing)
    }
    
    private func sizeButton(frame: FrameProperties, isSelected: Bool) -> some View {
        Button {
            selectedFrame = frame
            size = frame.size
        } label: {
            VStack {
                Image(systemName: frame.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity)
                    .foregroundStyle(.myBlue)

                Text(frame.buttonText)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .background(.myBlue)
                    .clipShape(Capsule())
                    .foregroundStyle(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isSelected ? .black : .myBackground)
            .cornerRadius(8)
            .scaleEffect(isSelected ? 1.05 : 1.0)
        }
    }
}

extension GeneratedImageView {
    private func editImage() async {
        buttonState = .proccessing
        let imageSize = size ?? "1024x1024"
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        buttonState = .success
//        if let finalImage = await AIService().generateImage(image, prompt, imageSize) {
//            image = finalImage
//            buttonState = .success
//        } else {
//            buttonState = .failure
//        }
        
        try? await Task.sleep(nanoseconds: 4_000_000_000)
        buttonState = .start
    }
    
    private func downloadAction() {
        isDownloadButtonPressed = true
        animationAmount = 1.0
        withAnimation (.easeInOut(duration: 1)) {
            animationAmount = 2.0
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

#Preview {
    GeneratedImageView(image: .gta, prompt: .bubbleHead)
}
