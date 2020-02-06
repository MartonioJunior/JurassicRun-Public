//
//  GameView.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class GameView: ViewCode {
    var root: SKNode
    var isActive: Bool {
        didSet {
            self.root.isHidden = !self.isActive
            self.root.isUserInteractionEnabled = self.isActive
        }
    }

    init(reference node: SKNode? = nil) {
        self.root = SKNode()
        self.root.zPosition = 50
        self.isActive = true
        guard let node = node else { return }
        setupView(for: node)
    }

    func setupView(for node: SKNode) {
        self.root.removeAllChildren()
        self.root.name = "View"
        self.setupView()
        node.addChild(root)
    }

    convenience init(scene: GameScene) {
        guard let camera = scene.camera() else {
            self.init(reference: scene)
            return
        }
        self.init(reference: camera)
    }

    deinit {
        self.root.removeAllChildren()
        self.root.removeFromParent()
    }

    func setupConstraints() {

    }

    func buildViewHierarchy() {

    }

    func configureAdditionalInformation() {

    }

    func toggleController() {
        self.isActive = !self.isActive
    }

    #if os(iOS) || os(macOS)
    func touch(at point: CGPoint) {
        let selectedNode = self.root.atPoint(point)
        if let boardTile = selectedNode as? SKBoardTile {
            
        }
    }
    #endif
}
