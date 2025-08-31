//
//  AroundEgyptApp.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import SwiftUI

@main
struct AroundEgyptApp: App {
    @StateObject private var diContainer = AppDIContainer()

    init() {
        FontsManger.shared.registerFonts()
    }
    var body: some Scene {
        WindowGroup {
            diContainer.makeHomeView()
                .environmentObject(diContainer)
        }
    }
}
