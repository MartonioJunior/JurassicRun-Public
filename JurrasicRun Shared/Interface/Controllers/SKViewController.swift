//
//  SKViewController.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class SKViewController: ViewCode {
    var root: SKNode
    var isActive: Bool {
        didSet {
            self.root.isHidden = self.isActive
            self.root.isUserInteractionEnabled = self.isActive
        }
    }

    init(reference node: SKNode? = nil) {
        self.root = SKNode()
        self.root.zPosition = 50
        self.isActive = true
        guard let node = node else { return }
        setupController(for: node)
    }

    func setupController(for node: SKNode) {
        self.root.removeAllChildren()
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
        
    }
    #endif
}
