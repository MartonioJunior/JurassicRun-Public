//
//  GameViewController.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 27/09/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene.current

        guard let skView = self.view as? SKView else { return }

        if let currentScene = scene.rootNode as? GameScene {
            skView.presentScene(currentScene)
        }
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
