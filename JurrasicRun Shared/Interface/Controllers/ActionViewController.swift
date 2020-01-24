//
//  ActionViewController.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class ActionViewController: SKViewController {
    lazy var button: SKButton = {
        let button = SKButton(frame: .zero)
        return button
    }()

    override func buildViewHierarchy() {
        root.addChild(button)
    }

    override func setupConstraints() {
        button.setFrame(CGRect(x: 16, y: 16, width: 16, height: 16))
    }
}
