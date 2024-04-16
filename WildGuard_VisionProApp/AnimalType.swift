//
//  AnimalType.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27/01/2024.
//

import SwiftUI

enum AnimalType: String, CaseIterable {
    case earth, sea, sky

    var icon: String {
        switch self {
        case .earth:
            "pawprint"
        case .sea:
            "fish"
        case .sky:
            "bird"
        }
    }

    var description: String {
        switch self {
        case .earth:
            "Diverse species that roam the earth, from majestic elephants to elusive big cats, facing significant threats such as habitat loss and poaching."
        case .sea:
            "An immense array of marine life, from the tiny seahorse to the colossal blue whale, endangered by issues such as overfishing and human pollution."
        case .sky:
            "Birds and insects, including the graceful albatross and the industrious bee, struggling with challenges like climate change and habitat destruction."
        }
    }

    #if os(visionOS)
    var background: Material {
        .regularMaterial
    }
    #else
    var background: Color {
        switch self {
        case .earth:
            .green
        case .sea:
            .blue
        case .sky:
            .orange
        }
    }
    #endif
}
