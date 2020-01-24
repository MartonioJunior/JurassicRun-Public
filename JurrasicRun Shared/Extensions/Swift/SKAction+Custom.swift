//
//  SKAction+Custom.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 22/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

extension SKAction {
    static func move(_ nodeA: SKNode, towards nodeB: SKNode, speed: CGFloat) -> SKAction {
        let groupAction = SKAction.group([
            SKAction.run({
                var normalVector = nodeA.position.distanceVector(to: nodeB.position)
                let speedValue = Float(speed)
                let distanceValue = abs(normalVector.sum())
                if distanceValue > speedValue {
                    normalVector = (normalVector / distanceValue) * speedValue
                }
                let newPoint = nodeA.position.distanceVector(to: CGPoint.create(from: normalVector))
                nodeA.position = CGPoint.create(from: newPoint)
            }),
            SKAction.wait(forDuration: 0.016)
        ])
        return repeatForever(groupAction)
    }
}
