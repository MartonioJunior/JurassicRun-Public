//
//  ActionView.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 28/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class ActionView: GameView {
    lazy var buttons: [SKButton] = {
        var buttons: [SKButton] = []
        for action in actions {
            let button = SKButton(frame: .zero)
            buttons.append(button)
        }
        return buttons
    }()
    var actions: [PlayerActionComponent] = []
    let radius: Double = 25.0

    override func setupView(for node: SKNode) {
        guard let actor = node as? Actor,
            let entity = actor.entity() else { return }
        actions = entity.allComponents(ofType: PlayerActionComponent.self)
        super.setupView(for: node)
    }

    override func buildViewHierarchy() {
        for index in 0..<buttons.count {
            let button = buttons[index]
            button.text = actions[index].name
            root.addChild(button)
        }
    }

    override func setupConstraints() {
        let angleSlice = Double.toRadians(degrees: Double(360/buttons.count))
        var currentAngle = 0.0
        for button in buttons {
            let deltaX = cos(currentAngle)*radius
            let deltaY = sin(currentAngle)*radius
            let frame = CGRect(x: deltaX, y: deltaY, width: 20, height: 20)
            button.setFrame(frame)
            currentAngle += angleSlice
        }
    }
}
