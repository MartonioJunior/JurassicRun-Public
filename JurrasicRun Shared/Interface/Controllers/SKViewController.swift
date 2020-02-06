//
//  SKViewController.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 28/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class SKViewController {
    // MARK: Variables
    weak var actor: Actor?
    weak var interface: GameInterface?

    // MARK: Initializers
    init(on interface: GameInterface) {
        self.interface = interface
    }

    deinit {
        self.root()?.removeAllChildren()
        self.root()?.removeFromParent()
    }

    // MARK: Methods
    func setup() {

    }

    func root() -> SKNode? {
        return view()?.root
    }

    func view() -> GameView? {
        return nil
    }
}
