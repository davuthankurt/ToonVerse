//
//  GeneratedImageView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 21.05.2025.
//

import SwiftUI


struct GeneratedImageView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.navigator) var navigator
    
    @State var image: UIImage
    @State var selectedFilter: AIFilter
    @State var size: String?
    var imageToGenerate: UIImage
    
    @State private var isFiltersShown = false
    @State private var isFramePopupActive = false
    @State private var rotationAngle = 0.0
    @State private var selectedFrame: FrameProperties?
    @State private var buttonState: ButtonState = .start
    @State private var isDownloadButtonPressed = false
}

extension GeneratedImageView {
    var body: some View {
        zStackView
            .background(.myBackground)
            .toolbar(.visible)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .disabled(buttonState != .start)
                    .opacity( buttonState != .start ? 0.5 : 1.0 )
                    .animation(.linear, value: buttonState)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.smooth(duration: 0.6)) {
                            isFiltersShown.toggle()
                        }
                        
                    } label: {
                        Text (isFiltersShown ? "Hide Filters" : "Show Filters")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .disabled(buttonState != .start)
                    .opacity(buttonState != .start ? 0.5 : 1.0)
                    .animation(.linear, value: buttonState)
                }
            }
    }
    
    private var zStackView: some View {
        ZStack {
            if isFramePopupActive {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.8)) {
                            isFramePopupActive = false
                            if rotationAngle == 720 {
                                rotationAngle -= 720
                            }
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
            if isFiltersShown {
                filterStack
                    .transition(.scale.animation(.smooth))
            }
            viewImage(image)
            Spacer()
            buttonStack
        }
    }
    
    private var filterStack: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(AIFilter.allCases) { filter in
                    Button {
                        selectedFilter = filter
                    } label: {
                        Image(filter.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                            .clipShape(.rect(cornerRadius: 8))
                            .overlay {
                                if filter == selectedFilter {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.myBlue.opacity(0.5), lineWidth: 3)
                                }
                            }
                            .scaleEffect(filter == selectedFilter ? 1.1 : 1.0)
                    }
                }
            }
            .padding()
        }
        .opacity(isFramePopupActive ? 0.5 : 1.0)
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
            DownloadButtonView(image: $image,
                               isDownloadButtonPressed: $isDownloadButtonPressed,
                               buttonState: $buttonState,
                               isFramePopupActive: $isFramePopupActive)
            .padding(.leading)
            .disabled(isFramePopupActive || buttonState != .start)
            .opacity(isFramePopupActive ? 0.5 : 1.0)
            .shadow(
                color: buttonState.color,
                radius: 5
            )
            
            GenerateButtonView(buttonState: $buttonState,
                               isFramePopupActive: $isFramePopupActive,
                               size: $size,
                               imageToShow: $image,
                               prompt: $selectedFilter,
                               imageToGenerate: imageToGenerate,
                               navigator: navigator)
            .padding()
            .disabled(isFramePopupActive || buttonState != .start)
            .opacity(isFramePopupActive ? 0.5 : 1.0)
            .shadow(
                color: buttonState.color,
                radius: 5
            )

            FrameButtonView(isFramePopupActive: $isFramePopupActive,
                            rotationAngle: $rotationAngle,
                            buttonState: $buttonState)
                .padding(.trailing)
                
        }
        .animation(.linear, value: buttonState)
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

#Preview {
    GeneratedImageView(image: .gta, selectedFilter: .bubbleHead, imageToGenerate: .gta)
}
