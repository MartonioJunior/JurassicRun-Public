//
//  Human+SpriteKitIntegration.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 19/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import JurrasicRunBoard

extension Human {
    override func getAssociatedNode() -> Character? {
        let components = GameComponentSystem.getSystem(.playerLogic)?.components as? [PlayerLogicComponent]
        let correspondingComponent = components?.first(where: {
            return $0.human === self
        })
        return correspondingComponent?.node
    }
}
