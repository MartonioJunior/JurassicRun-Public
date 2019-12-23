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
    weak var node: SKDinosaur?

    override init() {
        self.dinosaur = Dinosaur()
        super.init()
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor as? SKDinosaur
    }

    static func allDinosaurs() -> [Dinosaur] {
        guard let components = GameComponentSystem.getSystem(.dinosaurLogic)?.components
            as? [DinosaurLogicComponent] else { return [] }
        let dinosaur = components.map { $0.dinosaur }
        return dinosaur
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime time: TimeInterval) {

    }
}
