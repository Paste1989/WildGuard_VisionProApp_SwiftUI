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
        
        //open window
        WindowGroup(for: String.self) { $string in
            if let string {
               Image(string)
                    .resizable()
                    .scaledToFill()
            }
        }
        .defaultSize(width: 1000, height: 1000)
        
        WindowGroup(for: Animal.self) { $animal in
            if let animal {
                ZoomedView(animal: animal)
            }
        }
        .defaultSize(width: 1, height: 1, depth: 0.5, in: .meters)
        .windowStyle(.volumetric)
        
        
        ImmersiveSpace(id: "Max") {
            Image("Red Panda")
                .resizable()
                .frame(width: 1000, height: 1000)
        }
        .immersionStyle(selection: .constant(.full), in: .mixed, .full)
    }
}
