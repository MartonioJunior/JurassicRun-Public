//
//  GameControllerComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 09/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import JurrasicRunBoard
import GameplayKit

class GameControllerComponent: GKComponent {
    var controller: GameController

    override init() {
        self.controller = GameController()
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        print("Controller!")
    }
}
