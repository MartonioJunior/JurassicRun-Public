//
//  Settings.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import CoreGraphics

enum Settings {

    struct Camera {
        static let minZoom: CGFloat = 0.5
        static let maxZoom: CGFloat = 1.3
        static let maxSpeed: CGFloat = 5 // per frame
    }

    struct Animation {
        static let timePerFrame = 0.0625 // seconds
        static var speed = 1.0

        static let labelFadeInDefaultTime = 0.5 / Settings.Animation.speed // seconds
        static let labelAppearenceTime = 3.0 / Settings.Animation.speed // seconds
        static let labelFadeOutDefaultTime = 0.5 / Settings.Animation.speed // seconds
    }

    struct Debug {

    }

    struct Gameplay {

    }

    struct GameplayKit {
        static let quadTreeCellSize: Float = 20.0 // pixels
    }

    struct General {

    }

    struct Input {
        #if os(iOS) || os(tvOS)
        static let touchRadius: CGFloat = 60.0 // pixels
        static let numberOfTouches: Int = 1
        #endif
    }

    struct Rendering {

    }

    struct Scene {
        static let limitBounds: CGRect = CGRect(x: -2048, y: -2048, width: 4096, height: 4096)
        static let pathOffset: CGPoint = CGPoint(x: 0, y: -16)
    }
}
