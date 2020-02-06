//
//  MovementComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 20/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

struct MovementKind {
    // MARK: Properties
    let isRelativeToOrientation: Bool
    let movementDelta: SIMD2<Float>

    // MARK: Initializers
    init(movementDelta: SIMD2<Float>, relativeToOrientation: Bool = false) {
        isRelativeToOrientation = relativeToOrientation
        self.movementDelta = movementDelta
    }

    init(from pointA: CGPoint, to pointB: CGPoint) {
        let movementDelta = pointB.distanceVector(to: pointA)
        self.init(movementDelta: movementDelta)
    }

    func distance() -> Double {
        return Double(length(self.movementDelta))
    }
}

class MovementComponent: GKComponent {
    // MARK: Properties
    var movementSpeed: Double
    var angularSpeed: Double = 0.5
    var isMoving: Bool = false
    var nextTranslation: MovementKind?
    weak var node: Actor?

    // MARK: Initializers
    init(speed: Double) {
        self.movementSpeed = speed
        super.init()
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        guard let nextTranslation = nextTranslation,
            let actor = node, !isMoving else { return }
        let movementTime = TimeInterval(nextTranslation.distance() / self.movementSpeed)
        let moveAction = SKAction.move(by: CGVector.create(from: nextTranslation.movementDelta),
                                       duration: movementTime)
        self.isMoving = true
        actor.isPaused = false
        actor.run(moveAction) {
            self.nextTranslation = nil
            self.isMoving = false
        }
    }

    func setNew(_ position: CGPoint) {
        if let nodePoint = node?.position {
            self.nextTranslation = MovementKind(from: nodePoint, to: position)
        } else {
            self.nextTranslation = MovementKind(from: CGPoint.zero, to: position)
        }
    }
}
