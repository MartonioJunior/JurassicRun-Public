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
    var isMoving: Bool {
        return nextTranslation != nil
    }

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
//        guard let nextTranslation = nextTranslation,
//            let actor = node, !actor.hasActions(),
//            let newPosition = nextPosition(for: actor, withTranslation: nextTranslation,
//                                           duration: seconds) else { return }
//        actor.position = newPosition
        guard let nextTranslation = nextTranslation,
            let actor = node, !actor.hasActions() else { return }
        let movementTime = TimeInterval(nextTranslation.distance() / self.movementSpeed)
        actor.run(SKAction.move(by: CGVector.create(from: nextTranslation.movementDelta), duration: movementTime)) {
            print("Completed movement!")
            self.nextTranslation = nil
        }
    }

    func nextPosition(for node: SKNode, withTranslation translation: MovementKind, duration: TimeInterval) -> CGPoint? {
        guard translation.movementDelta != SIMD2<Float>() else { return nil }
        let movementDelta = translation.movementDelta
        let angle = CGFloat(atan2(movementDelta.y, movementDelta.x))
        let maxPossibleDistanceToMove = CGFloat(movementSpeed) * CGFloat(duration)
        let normalizedMovementDelta = length(movementDelta) > 1.0 ? normalize(movementDelta) : movementDelta

        let actualDistanceToMove = CGFloat(length(normalizedMovementDelta)) * maxPossibleDistanceToMove
        let deltaX = actualDistanceToMove * cos(angle)
        let deltaY = actualDistanceToMove * sin(angle)

        return node.position.applying(CGAffineTransform(translationX: deltaX, y: deltaY))
    }
}
