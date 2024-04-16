//
//  Animal.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27/01/2024.
//

import Foundation

struct Animal: Codable, Comparable, Hashable, Identifiable {
    var id: String { scientificName }
    var englishName: String
    var scientificName: String
    var continent: String
    var estimatedPopulation: String
    var endangeredRating: String
    var description: String
    var url: URL
    var mapRotationX: Double
    var mapRotationY: Double

    var mapImage: String {
        "\(englishName) Map"
    }

    var favoritesKey: String {
        "Favorite-\(englishName)"
    }

    static func <(lhs: Animal, rhs: Animal) -> Bool {
        lhs.englishName < rhs.englishName
    }

    static let example = Animal(englishName: "Example Animal", scientificName: "Animalis Exemplar", continent: "North Westalis", estimatedPopulation: "1,000", endangeredRating: "Just fine, thanks", description: "This is not an endangered animal, or even a real animal.", url: .documentsDirectory, mapRotationX: 0, mapRotationY: 0)
}
