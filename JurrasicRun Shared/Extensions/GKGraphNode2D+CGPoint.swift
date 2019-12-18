//
//  GKGraphNode2D+CGPoint.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 17/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit
import CoreGraphics

extension GKGraphNode2D {
    static func create(with point: CGPoint) -> GKGraphNode2D {
        return GKGraphNode2D(point: [Float(point.x), Float(point.y)])
    }
}
