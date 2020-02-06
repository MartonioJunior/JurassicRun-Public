//
//  Double+DegreeRadianConversion.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 28/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

extension Double {
    static func toRadians(degrees: Double) -> Double {
        return degrees * Double.pi / 180.0
    }

    static func toDegrees(radians: Double) -> Double {
        return radians * 180.0 / Double.pi
    }
}
