//
//  GameScene+Controls.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 21/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import UIKit
import GameplayKit

#if os(iOS) || os(tvOS)
extension GameScene: UIGestureRecognizerDelegate {
    // MARK: Setup
    func setupControls() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        self.view?.addGestureRecognizer(singleTapGesture)
        singleTapGesture.delegate = self

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        self.view?.addGestureRecognizer(pinchGesture)
        pinchGesture.delegate = self

        let dragGesture = UILongPressGestureRecognizer(target: self, action: #selector(drag(_:)))
        dragGesture.allowableMovement = 0
        dragGesture.minimumPressDuration = 0
        dragGesture.numberOfTouchesRequired = 1
        dragGesture.numberOfTapsRequired = 0
        self.view?.addGestureRecognizer(dragGesture)
        dragGesture.delegate = self
    }

    // MARK: Controls
    @objc func singleTap(_ recognizer: UITapGestureRecognizer) {
        print("Tap: \(recognizer.state.rawValue)")
        let location = TouchLocationData(recognizer)
        let touchRect = GKQuad.create(in: location.scene, withRadius: Settings.Input.touchRadius)
        if let selectedSpace = board?.quadTree.elements(in: touchRect).first,
            let selectedTile = selectedSpace.boardTile {
            interface?.selected(tile: selectedTile, on: self)
            selectedSpace.color = .blue
        }
    }

    @objc func drag(_ recognizer: UILongPressGestureRecognizer) {
        print("Drag: \(recognizer.state.rawValue)")
        self.camera()?.updateCameraPosition(recognizer)
    }

    @objc func pinch(_ recognizer: UIPinchGestureRecognizer) {
        print("Pinch: \(recognizer.state.rawValue)")
        self.camera()?.updateCameraZoom(recognizer)
    }

    // MARK: Delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
#endif
