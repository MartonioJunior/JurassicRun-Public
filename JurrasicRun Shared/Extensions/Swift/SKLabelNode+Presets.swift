//
//  SKLabelNode+Presets.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 21/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    // MARK: Label Presets
    static func mainTitle(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "San Francisco")
        label.fontSize = 48
        label.fontColor = .black
        label.text = text
        label.zPosition = 10
        return label
    }

    static func mainDetail(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "San Francisco")
        label.fontSize = 36
        label.fontColor = .black
        label.text = text
        label.zPosition = 10
        return label
    }

    static func secondaryTitle(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 30
        label.fontColor = .systemBlue
        label.text = text
        label.zPosition = 10
        return label
    }

    static func secondaryDetail(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 24
        label.fontColor = .systemBlue
        label.text = text
        label.zPosition = 10
        return label
    }

    static func buttonMain(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 8
        label.fontColor = .systemBlue
        label.text = text
        label.zPosition = 10
        return label
    }

    static func buttonDetail(with text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.fontSize = 6
        label.fontColor = .systemBlue
        label.text = text
        label.zPosition = 10
        return label
    }
}
