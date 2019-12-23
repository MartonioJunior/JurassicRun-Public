//
//  PlayerLogicComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit
import JurrasicRunBoard

class PlayerLogicComponent: GKComponent {
    var human: Human
    weak var node: SKHuman?

    override init() {
        self.human = Human()
        super.init()
    }
    
    override func didAddToEntity() {
        self.node = self.entity()?.actor as? SKHuman
    }

    static func allHumans() -> [Human] {
        guard let components = GameComponentSystem.getSystem(.playerLogic)?.components
            as? [PlayerLogicComponent] else { return [] }
        let humans = components.map { $0.human }
        return humans
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {

    }
}
