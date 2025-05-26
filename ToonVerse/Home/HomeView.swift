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
        scrollView
            .photosPicker(isPresented: $isShowingPicker, selection: $selectionModel.selectedItem, matching: .any(of: [.images, .screenshots, .livePhotos]))
            .onChange(of: selectionModel.selectedItem) { _, newItem in
                selectedItemChanged(newItem)
            }
    }
    
    private var scrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            filterStack
        }
        .ignoresSafeArea()
        .background(Color(red: 20/255, green: 25/255, blue: 30/255))
    }
    
    private var filterStack: some View {
        HStack {
            ForEach(AIFilter.allCases) { filter in
                filterView(filter)
            }
        }
    }
    
    private func filterView(_ filter: AIFilter) -> some View {
        VStack {
            filterImage(filter)
            filterText(filter)
        }
    }
    
    private func filterImage(_ filter: AIFilter) -> some View {
        Image(filter.image)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
            .onTapGesture {
                isShowingPicker = true
                selectionModel.selectedPrompt = filter
            }
            .padding()
    }
    
    private func filterText(_ filter: AIFilter) -> some View {
        Text(filter.title)
            .font(.title3)
            .bold()
            .foregroundStyle(.white)
            .padding(.bottom)
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
