//
//  HomeView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 22.05.2025.
//

import SwiftUI
import PhotosUI
import NavigatorUI

struct HomeScreen: View {
    @Environment(\.navigator) var navigator
    @State private var selectionModel = SelectionModel()
    @State private var isShowingPicker = false
}

extension HomeScreen {
    var body: some View {
        ScrollView {
            LandscapeView(isShowingPicker: $isShowingPicker)
            PortraitView(isShowingPicker: $isShowingPicker)
            SquareView(isShowingPicker: $isShowingPicker)
        }
        .environment(selectionModel)
        .photosPicker(isPresented: $isShowingPicker, selection: $selectionModel.selectedItem, matching: .any(of: [.images, .screenshots, .livePhotos]))
        .onChange(of: selectionModel.selectedItem) { _, newItem in
            selectedItemChanged(newItem)
        }
        .onAppear {
            navigator.navigate(to: HomeDestinations.paywallScreen, method: .cover)
        }
        .background(.myBackground)
    }
}

extension HomeScreen {
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
    HomeScreen()
}
