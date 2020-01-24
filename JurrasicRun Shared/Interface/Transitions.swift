//
//  Transitions.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class Transitions {
    static func pan(to nextPlayer: PlayerLogicComponent, on scene: GameScene) {
        guard let camera = scene.camera(),
            let currentPlayer = scene.controller?.currentPlayer,
            let node = currentPlayer.node else { return }
        let label = SKLabelNode.mainTitle(with: currentPlayer.type+" time!")
        label.position = .zero
        label.alpha = 0
        camera.addChild(label)
        camera.setFocus(on: node)
        label.show(completion: {
            label.removeFromParent()
            camera.removeFocus()
            scene.interface?.showActionMenu(on: scene)
        })
    }
}
