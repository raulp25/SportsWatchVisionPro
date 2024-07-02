//
//  SpaceDestinationView.swift
//  SportsWatch
//
//  Created by Raul Pena on 02/02/24.
//

import SwiftUI
import RealityKit
import Combine

/// A view that displays a 360 degree scene in which to watch video.
struct SpaceDestinationView: View {
    
    @State private var destination: SpaceDestination
    @State private var destinationChanged = false
    
    @Environment(SpaceDestinationsModel.self) private var model
    
    init(_ destination: SpaceDestination) {
        self.destination = destination
    }
    
    var body: some View {
        RealityView { content in
            let rootEntity = Entity()
            Task {
                await rootEntity.addSkybox(for: destination)
            }
            content.add(rootEntity)
        } update: { content in
            guard destinationChanged else { return }
            guard let entity = content.entities.first else { fatalError() }
            Task {
                await entity.updateTexture(for: destination)
            }
            Task { @MainActor in
                destinationChanged = false
            }
        }
        // Handle the case where:
        // 1. The user opens a different destination skybox view
        // 2. The user closes the current destination skybox view
        .onChange(of: model.currenSpacetDestination) { oldValue, newValue in
            if let newValue, destination != newValue {
                destination = newValue
                destinationChanged = true
            }
        }
        .transition(.opacity)
    }
}

extension Entity {
    func addSkybox(for destination: SpaceDestination) async {
        do {
            let texture = try await TextureResource(named: destination.url)
            
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            self.components.set(ModelComponent(
                // mesh: .generateSphere(radius: 1E3),
                mesh: .generateSphere(radius: 40.0),
                materials: [material]
            ))
            self.scale *= .init(x: -1, y: 1, z: 1)
            self.transform.translation += SIMD3<Float>(0.0, 1.0, 0.0)
            
            // Rotate the sphere to show the best initial view of the space.
            updateRotation(for: destination)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTexture(for destination: SpaceDestination) async {
        do {
            let texture = try await TextureResource(named: destination.url)
            
            guard var modelComponent = self.components[ModelComponent.self] else {
                fatalError("Should this be fatal? Probably.")
            }
            
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            modelComponent.materials = [material]
            self.components.set(modelComponent)
            
            // Rotate the sphere to show the best initial view of the space.
            updateRotation(for: destination)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateRotation(for destination: SpaceDestination) {
        // Rotate the immersive space around the Y-axis set the user's
        // initial view of the immersive scene.
        let angle = Angle.degrees(90)
        let rotation = simd_quatf(angle: Float(angle.radians), axis: SIMD3<Float>(0, 1, 0))
        self.transform.rotation = rotation
    }
}

#Preview {
    SpaceDestinationView(DeveloperPreview.shared.spaceDestinationStadium)
}
