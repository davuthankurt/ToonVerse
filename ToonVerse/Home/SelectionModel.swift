//
//  SelectedImageModel.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 23.05.2025.
//

import SwiftUI
import PhotosUI

final class SelectionModel: ObservableObject {
    @Published var selectedImage: Image?
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedPrompt: AIFilter?
}
