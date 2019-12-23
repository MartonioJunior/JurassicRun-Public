//
//  GKQuad+CGRect.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

extension GKQuad {
    static func create(with rect: CGRect) -> GKQuad {
        return GKQuad(quadMin: rect.min().vector2(), quadMax: rect.max().vector2())
    }

    static func create(in point: CGPoint, withRadius radius: CGFloat) -> GKQuad {
        let vectorPoint = point.vector2()
        let delta = Float(radius)
        return GKQuad(quadMin: [vectorPoint[0] - delta, vectorPoint[1] - delta],
                      quadMax: [vectorPoint[0] + delta, vectorPoint[1] + delta])
    }
}
