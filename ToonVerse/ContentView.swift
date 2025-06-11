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
            HomeScreen()
                .navigationDestination(HomeDestinations.self)
                .navigationTitle("ToonVerse")
                .toolbarBackground(Color.myBackground, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}

