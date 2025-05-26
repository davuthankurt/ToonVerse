//
//  ToonVerseApp.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 8.05.2025.
//

import SwiftUI
import AIProxy

@main
struct ToonVerseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
            AIProxy.configure(
                logLevel: .debug,
                printRequestBodies: false,  // Flip to true for library development
                printResponseBodies: false, // Flip to true for library development
                resolveDNSOverTLS: true,
                useStableID: false         // Please see the docstring if you'd like to enable this
            )
        }
}
