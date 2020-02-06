//
//  SKLabelNode+Animations.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 21/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    static func show(_ label: SKLabelNode, completion: (() -> Void)?) {
        label.show(completion: completion)
    }

    func show(completion: (() -> Void)?) {
        let fadeInTime = Settings.Animation.labelFadeInDefaultTime
        let appearenceTime = Settings.Animation.labelAppearenceTime
        let fadeOutTime = Settings.Animation.labelFadeOutDefaultTime
        show(fadeIn: fadeInTime, wait: appearenceTime, fadeOut: fadeOutTime, completion: completion)
    }

    static func show(_ label: SKLabelNode, fadeIn fadeInTime: TimeInterval,
                     wait waitTime: TimeInterval, fadeOut fadeOutTime: TimeInterval, completion: (() -> Void)?) {
        label.show(fadeIn: fadeInTime, wait: waitTime, fadeOut: fadeOutTime, completion: completion)
    }

    func show(fadeIn fadeInTime: TimeInterval, wait waitTime: TimeInterval,
              fadeOut fadeOutTime: TimeInterval, completion: (() -> Void)?) {
        let action = SKAction.sequence([
            SKAction.fadeIn(withDuration: fadeInTime),
            SKAction.wait(forDuration: waitTime),
            SKAction.fadeOut(withDuration: fadeOutTime)
        ])
        self.run(action) {
            guard let completion = completion else { return }
            completion()
        }
    }
}
