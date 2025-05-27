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
