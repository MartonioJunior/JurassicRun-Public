//
//  Settings.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import CoreGraphics

enum Settings {
    struct General {

    }

    struct Input {
        #if os(iOS) || os(tvOS)
        static let touchRadius: CGFloat = 60.0
        static let numberOfTouches: Int = 1
        #endif
    }

    struct Scene {
        static let limitBounds: CGRect = CGRect(x: -2048, y: -2048, width: 4096, height: 4096)
    }

    struct GameplayKit {
        static let quadTreeCellSize: Float = 20.0
    }

    struct Rendering {

    }
}
