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
        loadEntity()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
}
