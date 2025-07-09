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
    @EnvironmentObject var userModel: UserModel
    
    @StateObject private var selectionModel = SelectionModel()
    @State private var isShowingPicker = false
    @State private var remainingCredits = KeychainWrapper.standard.integer(forKey: "com.toonverse.remainingCredits") ?? 0
}

extension HomeScreen {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LandscapeView(isShowingPicker: $isShowingPicker)
            PortraitView(isShowingPicker: $isShowingPicker)
            SquareView(isShowingPicker: $isShowingPicker)
        }
    
        .environmentObject(selectionModel)
        .photosPicker(isPresented: $isShowingPicker, selection: $selectionModel.selectedItem, matching: .any(of: [.images, .screenshots, .livePhotos]))
        .onChange(of: selectionModel.selectedItem) { newItem in
            selectedItemChanged(newItem)
        }
        .onFirstAppear {
            if userModel.isSubscriptionActive == false {
                navigator.navigate(to: HomeDestinations.paywallScreen, method: .cover)
            }
        }
        .onAppear {
            remainingCredits = getRemainingCredits()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.navigate(to: HomeDestinations.settings)
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.navigate(to: HomeDestinations.paywallScreen, method: .cover)
                } label: {
                    ZStack(alignment: .bottomTrailing) {
                        Image(systemName: "bolt")
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        if !userModel.isSubscriptionActive {
                            Text("\(remainingCredits)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(3)
                                .background(Circle().fill(.myBlue))
                                .offset(x: 7, y: 3)
                        } else {
                            Image(systemName: "infinity.circle.fill")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .myBlue)
                                .font(.caption2)
                                .offset(x: 7, y: 3)
                        }
                    }
                }
            }
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
                selectionModel.selectedItem = nil
            }
        }
    }
    func getRemainingCredits() -> Int {
        return KeychainWrapper.standard.integer(forKey: "com.toonverse.remainingCredits") ?? 0
    }    
}



#Preview {
    var userModel = UserModel()
    HomeScreen()
        .environmentObject(userModel)
}
