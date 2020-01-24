//
//  Player.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class Actor: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = 1
        loadEntity()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        zPosition = 1
        loadEntity()
    }

    func setupComponents(_ actor: Actor) -> GameEntity? {
        return nil
    }

    func loadEntity() {
        guard let entity = setupComponents(self) else { return }
        self.entity = entity
        GameScene.buffer.insert(entity)
    }

    func entity() -> GameEntity? {
        return self.entity as? GameEntity
    }

    func getCameraFocus(deltaTime seconds: TimeInterval = 0) {
        guard let scene = self.scene as? GameScene, let camera = scene.camera() else { return }
        camera.setFocus(on: self, for: seconds)
    }

    func resignCameraFocus() {
        guard let scene = self.scene as? GameScene, let camera = scene.camera() else { return }
        camera.removeFocus()
    }
}
