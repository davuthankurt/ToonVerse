//
//  HomeView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 22.05.2025.
//

import SwiftUI
import PhotosUI
import NavigatorUI

struct HomeView: View {
    @Environment(\.navigator) var navigator
    @State private var selectionModel = SelectionModel()
    @State private var isShowingPicker = false
}

extension HomeView {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LandscapeView(selectionModel: $selectionModel, isShowingPicker: $isShowingPicker)
                PortraitView(selectionModel: $selectionModel, isShowingPicker: $isShowingPicker)
                SquareView(selectionModel:$selectionModel, isShowingPicker: $isShowingPicker)
            }
        }
        .photosPicker(isPresented: $isShowingPicker, selection: $selectionModel.selectedItem, matching: .any(of: [.images, .screenshots, .livePhotos]))
        .onChange(of: selectionModel.selectedItem) { _, newItem in
            selectedItemChanged(newItem)
        }
        .onAppear {
            navigator.navigate(to: HomeDestinations.paywallScreen, method: .cover)
        }
    }
}

extension HomeView {
    private func selectedItemChanged(_ newItem: PhotosPickerItem?) {
        Task {
            if let data = try? await newItem?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data),
               let prompt = selectionModel.selectedPrompt {
                navigator.navigate(to: HomeDestinations.generatedImageView(uiImage, prompt))
            }
        }
    }
}



#Preview {
    HomeView()
}
