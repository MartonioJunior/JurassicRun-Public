//
//  AnimationComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class AnimationComponent: GKComponent {
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

    func runAnimation(withTag tag: String, frameTime delta: TimeInterval, completion: ((Bool) -> Void)?) {
        guard let animation = self.getAnimation(withTag: tag) else { return }
        self.currentAnimationTag = self.getAnimationTag(for: tag)
        run(animation: animation, frameTime: delta, completion: completion)
    }

    func runAnimation(withTag tag: String, totalTime delta: TimeInterval, completion: ((Bool) -> Void)?) {
        guard let animation = self.getAnimation(withTag: tag) else { return }
        self.currentAnimationTag = self.getAnimationTag(for: tag)
        let numberOfImages = animation.textureNames.count
        let frameTime = delta / Double(numberOfImages)
        run(animation: animation, frameTime: frameTime, completion: completion)
    }

    var animationHasEnded: ((Bool) -> Void)?
    private func run(animation: SKTextureAtlas, frameTime delta: TimeInterval, completion: ((Bool) -> Void)?) {
        guard let node = node else { return }
        let animationTextures = animation.loadTextures()
        let action = SKAction.repeatForever(SKAction.animate(with: animationTextures, timePerFrame: delta))
        node.run(action)
        self.animationHasEnded = completion
    }

    func cancelAnimation() {
        guard let animationHasEnded = self.animationHasEnded else { return }
        animationHasEnded(true)
        self.animationHasEnded = nil
        guard let idleAnimationTag = getAnimationTag(for: "Idle") else {
            self.runAnimation(withTag: "basic", frameTime: 0.1, completion: nil)
            return
        }
        self.runAnimation(withTag: idleAnimationTag, frameTime: 0.1, completion: nil)
    }
}
