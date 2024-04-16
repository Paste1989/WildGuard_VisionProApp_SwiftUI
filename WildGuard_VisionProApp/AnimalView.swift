//
//  AnimalView.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27/01/2024.
//

import SwiftUI
import AVFoundation

struct AnimalView: View {    
    var animal: Animal
    @State private var selectedImage: String?

    @Environment(\.openURL) var openURL
    @Environment(\.openWindow) var openWindow
    @AppStorage("AnimalIsFavorite") var animalIsFavorite = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("**Rating:** \(animal.endangeredRating)")
                            .padding()
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))

                        Text("**Estimated population:** \(animal.estimatedPopulation)")
                            .padding()
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 10))
                    }

                    Text(animal.scientificName)
                        .italic()
                        .padding(.vertical, 20)

                    Text(animal.description)
                        .padding(.bottom, 20)

                    Spacer()

                    HStack {
                        Button {
                            ///openWindow
                            #if os(visionOS)
                            openWindow(value: animal.englishName)
                            #else
                            selectedImage = animal.englishName
                            #endif
                        } label: {
                            Image(animal.englishName)
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal) { size, axis in
                                    size * 0.3
                                }
                                .clipShape(.rect(cornerRadius: 15))
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 15))

//                        Image(animal.englishName)
//                            .resizable()
//                            .scaledToFit()
//                            .containerRelativeFrame(.horizontal) { size, axis in
//                                size * 0.3
//                            }
//                            .clipShape(.rect(cornerRadius: 15))
//                            .onTapGesture {
//                                selectedImage = animal.englishName
//                            }

                        Button {
                            ///openWindow
                            #if os(visionOS)
                            openWindow(value: animal)
                            #else
                            selectedImage = animal.mapImage
                            #endif
                        } label: {
                            Image(animal.mapImage)
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal) { size, axis in
                                    size * 0.3
                                }
                                .clipShape(.rect(cornerRadius: 15))
//                                .onTapGesture {
//                                    selectedImage = animal.mapImage
//                                }
                        }
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 15))
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)

            if let selectedImage {
                Image(selectedImage)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 20)
                    .onTapGesture {
                        self.selectedImage = nil
                    }
            }
        }
        .navigationTitle(animal.englishName)
        .padding([.horizontal, .bottom], 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .toolbar {
            //ToolbarItemGroup(placement: .bottomBar) {
                Toggle("Toggle Favorite", systemImage: "star", isOn: $animalIsFavorite)
                
                Button("Learn more", systemImage: "safari") {
                    openURL(animal.url)
                }

            //}

            ShareLink(item: animal.url)
        }
    }

    init(animal: Animal) {
        self.animal = animal
        _animalIsFavorite = AppStorage(wrappedValue: false, animal.favoritesKey)
    }
    
//    func makeMaxHappy() -> Entity {
//        let entity = Entity()
//        guard let url = Bundle.main.url(forResource: "Name", withExtension: "mp4") else {
//            print("no video")
//            return
//        }
//        
//        let asset = AVURLAsset(url: url)
//        let playerItem = AVPlayerItem(asset: asset)
//        let player = AVPlayer(playerItem: playerItem)
//        
//        var component = VideoPlayerComponent(avPlayer: player)
//        entity.components[VideoPlayerComponent.self] = component
//        player.play
//        
//        return entity
//    }
}

#Preview {
    AnimalView(animal: .example)
}
