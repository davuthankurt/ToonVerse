//
//  SelectedImageModel.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 23.05.2025.
//

import SwiftUI
import PhotosUI

extension HomeView {
    @Observable
    final class SelectionModel {
        var selectedImage: Image?
        var selectedItem: PhotosPickerItem?
        var selectedPrompt: AIFilter?
    }
}
