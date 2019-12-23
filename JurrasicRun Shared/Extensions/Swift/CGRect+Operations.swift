//
//  CGRect+Operations.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import CoreGraphics

extension CGRect {
    func min() -> CGPoint {
        return CGPoint(x: self.minX, y: self.minY)
    }

    func max() -> CGPoint {
        return CGPoint(x: self.maxX, y: self.maxY)
    }
}
