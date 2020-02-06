//
//  ActionViewController.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class ActionViewController: SKViewController {
    lazy var menu: ActionView = {
        let menu = ActionView()
        return menu
    }()

    override init(on interface: GameInterface) {
        super.init(on: interface)
    }

    override func setup() {
        guard let actor = actor else { return }
        menu.setupView(for: actor)

        // Button binding
        for index in 0..<menu.actions.count {
            let action = menu.actions[index]
            let button = menu.buttons[index]
            button.isActive = action.isEnabled && action.canAct()
            button.action = { _ in
                print(action.name)
                guard let scene = self.interface?.scene else { return }
                self.interface?.selected(action: action, on: scene)
            }
        }
    }

    override func view() -> GameView? {
        return menu
    }
}
