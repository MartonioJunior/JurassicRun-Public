//
//  InterfaceComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class InterfaceComponent: GKComponent {
    var controller: SKViewController
    weak var node: Actor?

    init(_ controller: SKViewController) {
        self.controller = controller
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        controller.root()?.removeAllChildren()
        controller.root()?.removeFromParent()
    }

    override func didAddToEntity() {
        guard let actor = self.entity()?.actor else { return }
        self.node = actor
        controller.actor = actor
        controller.setup()
    }

    override func update(deltaTime seconds: TimeInterval) {
        //self.controller.root()?.alpha = 1.0
    }
}
