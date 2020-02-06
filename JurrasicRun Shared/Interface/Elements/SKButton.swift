//
//  SKButton.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class SKButton: SKNode {
    // MARK: Widgets
    lazy var label: SKLabelNode = {
        return SKLabelNode.buttonMain(with: "")
    }()

    lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(color: .white, size: .zero)
        return background
    }()

    // MARK: Variables
    var text: String? {
        didSet {
            label.text = text
        }
    }

    var isActive: Bool = true {
        didSet {
            self.isHidden = !self.isActive
            self.isUserInteractionEnabled = self.isActive
        }
    }
    //var normalImage: SKTexture? // TODO: Remove optional
    //var highlightedImage: SKTexture? // TODO: Remove optional
    //var selectedButton: SKTexture? // TODO: Remove optional
    var action: ((SKButton) -> Void)?

    init(frame: CGRect) {
        super.init()
        self.setFrame(frame)
        self.addChild(background)
        self.addChild(label)
    }

    func setFrame(_ frame: CGRect) {
        self.position = frame.origin
        self.background.position = .zero
        self.background.size = frame.size
        self.label.position = .zero
        self.label.verticalAlignmentMode = .center
        self.label.horizontalAlignmentMode = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func selected() {
        guard let action = action else { return }
        action(self)
    }
}
