//
//  GKComponent+GameEntity.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 20/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

extension GKComponent {
    func entity() -> GameEntity? {
        return self.entity as? GameEntity
    }
}
