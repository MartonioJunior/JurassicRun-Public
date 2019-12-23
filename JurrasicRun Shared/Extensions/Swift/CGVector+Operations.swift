//
//  CGVector.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 20/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import CoreGraphics

extension CGVector {
    static func create(from vector2: SIMD2<Float>) -> CGVector {
        return CGVector(dx: CGFloat(vector2.x), dy: CGFloat(vector2.y))
    }
}
