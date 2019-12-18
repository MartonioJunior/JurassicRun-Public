//
//  GameViewController.swift
//  JurrasicRun macOS
//
//  Created by Martônio Júnior on 27/09/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let root = GameScene.current

        // Present the scene
        guard let skView = self.view as? SKView else { return }
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
}
