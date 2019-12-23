//
//  Human.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 09/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import JurrasicRunBoard

class SKHuman: Character {
    override func setupComponents(_ actor: Actor) -> GameEntity? {
        return GameEntity(with: [
            PlayerLogicComponent(),
            MovementComponent(speed: 60.0)
        ], for: self)
    }

    override func getPlayer() -> Player? {
        return self.entity?.component(ofType: PlayerLogicComponent.self)?.human
    }
}