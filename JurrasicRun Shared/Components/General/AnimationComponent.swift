//
//  AnimationComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class AnimationComponent: GKComponent {
    // MARK: Animation Properties
    var allAnimations: [String: SKTextureAtlas]
    var currentAnimationTag: String?
    var isAnimating: Bool {
        return currentAnimationTag != nil
    }
    weak var node: Actor?

    init(animations: [String: SKTextureAtlas]) {
        self.allAnimations = animations
        super.init()
    }

    convenience init(animationTags: [String]) {
        var animationDict: [String: SKTextureAtlas] = [:]
        for tag in animationTags {
            animationDict[tag] = SKTextureAtlas(named: tag)
        }
        self.init(animations: animationDict)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor
        guard let textureCG = self.node?.texture?.cgImage() else { return }
        let defaultAtlas = SKTextureAtlas(dictionary: ["0": UIImage(cgImage: textureCG)])
        allAnimations["basic"] = defaultAtlas
    }

    func getAnimation(withTag tag: String?) -> SKTextureAtlas? {
        guard let animationTag = getAnimationTag(for: tag) else { return nil }
        return self.allAnimations[animationTag]
    }

    func getAnimationTag(for tag: String?) -> String? {
        guard let tag = tag else { return nil }
        return allAnimations.keys.first(where: { $0.hasSuffix(tag)})
    }

    func run(_ action: SKAction, completion: (() -> Void)? = nil) {
        guard let node = node else { return }
        node.isPaused = false
        node.run(action) {
            guard let completion = completion else { return }
            completion()
        }
    }

    func run(_ tag: String, with movement: MovementKind? = nil, movementSpeed speed: Double = 1.0,
             frameTime delta: TimeInterval, loopForever: Bool = false, completion: (() -> Void)? = nil) {
        guard let animation = self.getAnimation(withTag: tag) else { return }
        var actions: [SKAction] = []
        var animationLoops = 1

        // Define move action
        if let movement = movement {
            let movementTime = TimeInterval(movement.distance() / speed)
            let moveAction = SKAction.move(by: CGVector.create(from: movement.movementDelta), duration: movementTime)
            actions.append(moveAction)
            let loopTime = TimeInterval(animation.textureNames.count) * delta
            animationLoops = Int(movementTime / loopTime)
        }

        // Define animation action
        let animationTextures = animation.loadTextures()
        let animationAction = SKAction.animate(with: animationTextures, timePerFrame: delta)
        if loopForever {
            actions.append(SKAction.repeatForever(animationAction))
        } else {
            actions.append(SKAction.repeat(animationAction, count: animationLoops+1))
        }
        self.run(SKAction.group(actions), completion: completion)
    }
}
