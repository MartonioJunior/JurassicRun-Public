//
//  CGPoint+Operations.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import CoreGraphics
import Foundation

extension CGPoint {
    func squareDistance(to point: CGPoint) -> CGFloat {
        let xDistance = self.x - point.x
        let yDistance = self.y - point.y
        return xDistance*xDistance + yDistance*yDistance
    }

    static func squareDistance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return pointA.squareDistance(to: pointB)
    }

    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(squareDistance(to: point))
    }

    static func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return pointA.distance(to: pointB)
    }

    func distanceVector(to point: CGPoint) -> SIMD2<Float> {
        return self.vector2() - point.vector2()
    }

    static func distanceVector(from pointA: CGPoint, to pointB: CGPoint) -> SIMD2<Float> {
        return pointA.distanceVector(to: pointB)
    }

    func vector2() -> SIMD2<Float> {
        return [Float(self.x), Float(self.y)]
    }

    static func create(from vector2: SIMD2<Float>) -> CGPoint {
        return CGPoint(x: CGFloat(vector2.x), y: CGFloat(vector2.y))
    }
}
