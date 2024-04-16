//
//  ZoomedView.swift
//  WildGuard
//
//  Created by Saša Brezovac on 27.01.2024..
//

import RealityKit
import RealityKitContent
import SwiftUI
import AVKit

struct ZoomedView: View {
    var animal: Animal
    
    @State private var spinX: CGFloat = 0.0
    @State private var spinY: CGFloat = 0.0
    
    var body: some View {
        RealityView { content, attachments in
            guard let texture1 = try? await TextureResource(named: "Earth") else { return }
            let globe = MeshResource.generateSphere(radius: 0.25)
            
            var material1 = UnlitMaterial()
            material1.color = .init(texture: .init(texture1))
            let model1 = ModelEntity(mesh: globe, materials: [material1]) // change material
            
            model1.components.set(GroundingShadowComponent(castsShadow: true))
            model1.components.set(InputTargetComponent())
            model1.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.25)])
            model1.name = "Earth"
            
            content.add(model1)
            
            ///rotation only one model in realityView
            let pitch = Transform(pitch: Float(animal.mapRotationX * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY)).matrix
            model1.transform.matrix = pitch * yaw
            
            if let attachment = attachments.entity(for: "name") {
                attachment.position = [0, -0.3, 0]
                content.add(attachment)
                
                //or
                //model1.addChild(attachment)
            }
            
            ///
            ///video material
            guard let url = Bundle.main.url(forResource: "Name", withExtension: "mp4") else {
                print("no video")
                return
            }
            let asset = AVURLAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            player.play()
            let videoMaterial = VideoMaterial(avPlayer: player)
            ///
            ///
   
        } update: { content, attachments in
            ///rotation UPDATE only one model in realityView
            guard let entity = content.entities.first else { return }
            let pitch = Transform(pitch: Float((animal.mapRotationX + spinX) * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY + spinY)).matrix
            entity.transform.matrix = pitch * yaw
            
        } attachments: {
            Attachment(id: "name") {
                Text("Location of \(animal.englishName)")
                    .font(.extraLargeTitle)
            }
        }
        .onAppear {
            spinX = animal.mapRotationX
            spinY = animal.mapRotationY
        }
        ///rotation whole RealityView
//        .rotation3DEffect(.radians(spinX), axis: .x)
//        .rotation3DEffect(.radians(spinY), axis: .y)
        .gesture(
            DragGesture(minimumDistance: 0)
                .targetedToAnyEntity()
                .onChanged { value in
                    let startLocation = value.convert(value.startLocation3D, from: .local, to: .scene)
                    let currentLocation = value.convert(value.location3D, from: .local, to: .scene)
                    let delta = currentLocation - startLocation
                    spinX = Double(-delta.y) * 5
                    spinY = Double(delta.x) * 5
                }
        )
        
        ///drag
        //                    .gesture(
        //                        DragGesture()
        //                            .targetedToAnyEntity()
        //                            .onChanged { value in
        //                                guard let parent = value.entity.parent else { return }
        //                                let newPosition =  value.convert(value.location3D, from: .local, to: parent)
        //                                value.entity.position = [newPosition.x, newPosition.y, value.entity.position.z]
        //                            }
        //                    )
        
        ///tap
        //        .gesture(
        //        TapGesture()
        //            .targetedToAnyEntity()
        //            .onEnded { value in
        //                guard let modelEntity = value.entity as? ModelEntity else { return }
        //
        //                let newMaterial = UnlitMaterial(color: .blue)
        //                modelEntity.model?.materials = [newMaterial]
        //            }
        //        )
        
       
    }
}

#Preview {
    ZoomedView(animal: .example)
}
