//
//  ContentView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 8.05.2025.
//

import SwiftUI
import PhotosUI
import NavigatorUI

struct ContentView: View {
    
    
    var body: some View {
        ManagedNavigationStack {
            HomeView()
                .navigationDestination(HomeDestinations.self)
        }
    }
}

#Preview {
    ContentView()
}


//        VStack {
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//                    .padding()
//            }
//            Button("select image") {
//                isShowingPicker = true
//            }
//            .padding()
//
//            Button(action: generateImage) {
//                Text("edit")
//            }
//            .padding()
//
//            Button(action: downloadImage) {
//                Text("download")
//            }
//            .padding()
//        }
//        .padding()
//        .photosPicker(isPresented: $isShowingPicker, selection: $selectedItem, matching: .images)
//        .onChange(of: selectedItem) { oldItem, newItem in
//            Task {
//                if let data = try? await newItem?.loadTransferable(type: Data.self),
//                   let uiImage = UIImage(data: data) {
//                    selectedImage = uiImage
//                }
//            }
//        }
//    }
//
//
//    func downloadImage() {
//        guard let image = selectedImage else { return }
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//    }
