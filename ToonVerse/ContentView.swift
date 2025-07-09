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
    @State private var isActive = false
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.myBackground)
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }
}

extension ContentView {
    var body: some View {
        Group {
            if isActive {
                ManagedNavigationStack {
                    HomeScreen()
                        .navigationDestination(HomeDestinations.self)
                        .navigationDestination(GenerateDestination.self)
                        .navigationTitle("ToonStellar")
                        .preferredColorScheme(.dark)
                }
                .tint(.white)
                
            } else {
                ZStack {
                    VStack {
                        Spacer()
                        Image(.toonverseLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .clipShape(.rect(cornerRadius: 24))
                            
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                        Color(red: 171/255, green: 167/255, blue: 243/255),
                        .myBlue
                    ]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    var userModel = UserModel()
    ContentView()
        .environmentObject(userModel)
}

