//
//  Camera.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 20/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    var lastPosition: CGPoint?
    var lockControls: Bool = false
    var lockPosition: Bool = false
    var lockZoom: Bool = true
    var zoomScale: CGFloat = 1.0

    init(in scene: GameScene) {
        super.init()
        scene.camera = self
        scene.addChild(self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setPosition(to position: CGPoint) {
        guard !lockPosition else { return }
        self.position = position
    }

    func movePosition(to position: CGPoint, duration: TimeInterval, completion: (() -> Void)?) {
        guard !lockPosition else { return }
        let action = SKAction.move(to: position, duration: duration)
        self.run(action) {
            guard let completion = completion else { return }
            completion()
        }
    }

    func updateCameraPosition(_ recognizer: UILongPressGestureRecognizer) {
        guard !lockControls else { return }
        let location = TouchLocationData(recognizer)
        switch recognizer.state {
        case .began:
            self.lastPosition = location.view
        case .changed:
            let location = location.view
            guard let lastPosition = self.lastPosition else { return }
            var delta = location.distanceVector(to: lastPosition) * Float(zoomScale)
            delta.y = -delta.y
            let cameraDelta = position.distanceVector(to: CGPoint.create(from: delta))
            self.setPosition(to: CGPoint.create(from: cameraDelta))
            self.lastPosition = recognizer.location(in: recognizer.view)
        default:
            break
        }
    }

    func setZoom(_ scale: CGFloat) {
        guard !lockZoom else { return }
        let zoomScale = min(max(Settings.Camera.minZoom, scale), Settings.Camera.maxZoom)
        self.zoomScale = zoomScale
        self.setScale(zoomScale)
    }

    func changeZoom(_ scale: CGFloat, duration: TimeInterval, completion: (() -> Void)?) {
        guard !lockZoom, (Settings.Camera.minZoom...Settings.Camera.maxZoom).contains(scale) else { return }
        let action = SKAction.scale(to: scale, duration: duration)
        self.run(action) {
            guard let completion = completion else { return }
            completion()
        }
    }

    func updateCameraZoom(_ recognizer: UIPinchGestureRecognizer) {
        guard !lockControls else { return }
        let location = TouchLocationData(recognizer)
        switch recognizer.state {
        case .began:
            self.lastPosition = location.view
        case .changed:
            let delta = zoomScale * (1.0/recognizer.scale)
            self.setZoom(delta)
            recognizer.scale = 1
        default:
            break
        }
    }

    func setFocus(on actor: Actor, for seconds: TimeInterval = 0) {
        var action: SKAction
        if seconds <= 0 {
            action = SKAction.move(self, towards: actor, speed: Settings.Camera.maxSpeed)
        } else {
            action = SKAction.move(to: actor.position, duration: seconds)
        }
        self.run(action)
    }

    func removeFocus() {
        self.removeAllActions()
    }
}
