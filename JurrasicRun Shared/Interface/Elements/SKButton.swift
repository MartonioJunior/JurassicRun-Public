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
        let background = SKSpriteNode(color: .blue, size: .zero)
        return background
    }()

    // MARK: Variables
    var text: String? {
        didSet {
            label.text = text
        }
    }
    var normalImage: SKTexture? // TODO: Remove optional
    var highlightedImage: SKTexture? // TODO: Remove optional
    var selectedButton: SKTexture? // TODO: Remove optional
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
        self.label.position = CGPoint(x: frame.width/2, y: frame.height/2)
        self.label.verticalAlignmentMode = .center
        self.label.horizontalAlignmentMode = .center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didSelect(_ button: SKButton) {
        guard let action = action else { return }
        action(button)
    }
}
