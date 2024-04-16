//
//  CategoryView.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27/01/2024.
//

import SwiftUI

struct CategoryView: View {
    @State private var selectedAnimals = Set<Animal>()
    @State private var searchText = ""
    var animals: [Animal]

    var filteredAnimals: [Animal] {
        if searchText.isEmpty {
            animals
        } else {
            animals.filter {
                $0.englishName.localizedStandardContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(animals, selection: $selectedAnimals, rowContent: AnimalRow.init)
                .searchable(text: $searchText)
        } detail: {
            if let animal = selectedAnimals.first {
                AnimalView(animal: animal)
            } else {
                Text("Select an animal for more information")
                    .font(.title)
            }
        }
    }

    init(type: AnimalType) {
        animals = Bundle.main.decode("\(type.rawValue).json", as: [Animal].self).sorted()
    }
}

#Preview {
    CategoryView(type: .earth)
}
