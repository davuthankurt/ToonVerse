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
    @State private var selectedFrame: FrameProperties?
}

extension GeneratedImageView {
    var body: some View {
        ZStack {
            Color.myBackground.ignoresSafeArea()
            if isFramePopupActive {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isFramePopupActive = false
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
            generateImage(image)
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
    
    private var buttonStack: some View {
        HStack {
            downloadButton
            generateButton
            frameButton
        }
    }
    
    private var downloadButton: some View {
        Button(action: downloadAction) {
            Image(systemName: "square.and.arrow.down")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding()
                .background(Color.myBlue)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .overlay {
            animationCircle
        }
        .padding(.leading)
    }
    
    private var animationCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.myBlue)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
            Circle()
                .stroke(Color.myBlue)
                .scaleEffect(animationAmount - 0.3)
                .opacity(2 - animationAmount)
        }
    }
    
    
    private func generateImage(_ image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 10))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
            .opacity(isFramePopupActive ? 0.5 : 1.0)
    }
    
    private var generateButton: some View {
        Button("Generate") {
            Task {
                await editImage()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(.myBlue)
        .clipShape(.capsule)
        .foregroundStyle(.white)
        .font(.title)
        .fontWeight(.bold)
        .padding()
    }
    
    private var frameButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.8)) {
                isFramePopupActive.toggle()
                rotationAngle += 720
            }
        } label: {
            Image(systemName: "rectangle.3.offgrid")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding()
                .background(Color.myBlue)
                .clipShape(Circle())
                .rotationEffect(.degrees(rotationAngle))
                .shadow(radius: 5)
        }
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
        let imageSize = size ?? "1024x1024"
        if let finalImage = await AIService().generateImage(image, prompt, imageSize) {
            image = finalImage
        }
    }
    
    private func downloadAction() {
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
