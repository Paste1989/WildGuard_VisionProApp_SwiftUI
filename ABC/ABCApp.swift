//
//  ABCApp.swift
//  ABC
//
//  Created by Saša Brezovac on 27.01.2024..
//

import SwiftUI

@main
struct ABCApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
