//
//  DinosaurLogicComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit
import JurrasicRunBoard

class DinosaurLogicComponent: GKComponent {
    var dinosaur: Dinosaur

    override init() {
        self.dinosaur = Dinosaur()
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime time: TimeInterval) {
        print("Dino!")
    }
}
