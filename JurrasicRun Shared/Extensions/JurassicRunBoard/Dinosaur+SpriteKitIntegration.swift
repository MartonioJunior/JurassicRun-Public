//
//  Dinosaur+SpriteKitIntegration.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 20/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import JurrasicRunBoard

extension Dinosaur {
    override func getAssociatedNode() -> Character? {
        let components = GameComponentSystem.getSystem(.dinosaurLogic)?.components as? [DinosaurLogicComponent]
        let correspondingComponent = components?.first(where: {
            return $0.dinosaur === self
        })
        return correspondingComponent?.node
    }
}
