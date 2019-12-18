//
//  GameEntity.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class GameEntity: GKEntity {
    weak var actor: Actor?

    init(with components: [GKComponent], for actor: Actor) {
        super.init()
        self.actor = actor
        for component in components {
            self.addComponent(component)
        }
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
