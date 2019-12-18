//
//  Human.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 09/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

class SKHuman: Actor {
    override func setupComponents(_ actor: Actor) -> GameEntity? {
        return GameEntity(with: [
            PlayerLogicComponent()
        ], for: self)
    }
}
