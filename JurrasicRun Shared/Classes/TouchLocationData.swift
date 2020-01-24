//
//  ToucLocatiohData.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 20/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import UIKit
import SpriteKit

struct TouchLocationData {
    var scene: CGPoint
    var view: CGPoint

    init(_ touch: UITouch) {
        self.view = touch.location(in: touch.view)
        guard let sceneView = touch.view as? SKView,
            let scene = sceneView.scene else {
                self.scene = .zero
                return
        }
        self.scene = touch.location(in: scene)
    }

    init(_ gesture: UIGestureRecognizer) {
        self.view = gesture.location(in: gesture.view)
        guard let sceneView = gesture.view as? SKView,
            let scene = sceneView.scene else {
                self.scene = .zero
                return
        }
        self.scene = scene.convertPoint(fromView: self.view)
    }
}
