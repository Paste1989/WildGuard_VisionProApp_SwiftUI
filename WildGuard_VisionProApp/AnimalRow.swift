//
//  AnimalRow.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27/01/2024.
//

import SwiftUI

struct AnimalRow: View {
    @AppStorage("AnimalIsFavorite") private var animalIsFavorite = false
    var animal: Animal

    var body: some View {
        Label {
            Text(animal.englishName)
        } icon: {
            if animalIsFavorite {
                Image(systemName: "star")
                    .foregroundStyle(.yellow)
                    .symbolVariant(.fill)
            }
        }
        .tag(animal)
    }

    init(animal: Animal) {
        _animalIsFavorite = AppStorage(wrappedValue: false, animal.favoritesKey)
        self.animal = animal
    }
}

#Preview {
    AnimalRow(animal: .example)
}
