//
//  SKGameScene.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    weak var root: GKScene?
    var board: GameBoard?
    var controller: GameBoardController?
    var interface: GameInterface?
    var spinnyNode: SKShapeNode?

    /// Variables to measure time
    var globalTimer: TimeInterval = 0
    var lastTime: TimeInterval = 0
    var controlsEnabled: Bool = true

    static var buffer: Set<GameEntity> = []
    static var current: GKScene = GKScene.loadScene(number: 1)

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = Camera(in: self)
    }

    func connectTo(_ root: GKScene) {
        self.root = root
        root.rootNode = self
    }

    func camera() -> Camera? {
        return self.camera as? Camera
    }

    func setUpScene() {
        // Remove all entities from the buffer
        while !GameScene.buffer.isEmpty {
            let entity = GameScene.buffer.removeFirst()
            if entity.actor != nil {
                GameScene.current.addEntity(entity)
            }
        }

        // Load Game information
        GameScene.current.loadGame()

        // Setup game controls
        guard let scene = self.scene else { return }
        self.setupControls()
        self.interface = GameInterface(scene: self)

        // Display game start!
        guard let currentPlayer = controller?.currentPlayer else { return }
        Transitions.pan(to: currentPlayer, on: self)

        // Debug touch interaction
        let width = (scene.size.width + scene.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: width, height: width), cornerRadius: width * 0.3)

        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))

            #if os(watchOS)
                // For watch we just periodically create one of these and let it spin
                // For other platforms we let user touch/mouse events create these
                spinnyNode.position = CGPoint(x: 0.0, y: 0.0)
                spinnyNode.strokeColor = SKColor.red
                self.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.wait(forDuration: 2.0),
                        SKAction.run({
                            guard let nodeChild = spinnyNode.copy() as? SKShapeNode else { return }
                            self.addChild(nodeChild)
                        })
                    ])
                ))
            #endif
        }
    }

    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = self.spinnyNode?.copy() as? SKShapeNode {
            spinny.position = pos
            spinny.strokeColor = color
            self.scene?.addChild(spinny)
        }
    }

    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif

    override func update(_ currentTime: TimeInterval) {
        // Update Scene Timers
        globalTimer = currentTime
        let deltaTime = currentTime - lastTime
        lastTime = currentTime

        guard let controller = root else { return }
        for entity in controller.entities {
            entity.update(deltaTime: deltaTime)
        }
    }

    override func willMove(from view: SKView) {
        view.gestureRecognizers = []
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene: UIResponderEvents {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = TouchLocationData(touch)
            self.makeSpinny(at: location.scene, color: SKColor.green)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = TouchLocationData(touch)
            self.makeSpinny(at: location.scene, color: SKColor.blue)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = TouchLocationData(touch)
            self.makeSpinny(at: location.scene, color: SKColor.red)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = TouchLocationData(touch)
            self.makeSpinny(at: location.scene, color: SKColor.red)
        }
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: scene)
        let touchRect = GKQuad.create(in: location, withRadius: Settings.Input.touchRadius)
        if let selectedSpace = board?.quadTree.elements(in: touchRect).first,
            let selectedTile = selectedSpace.boardTile {
            self.selected(tile: selectedTile, on: self)
            selectedSpace.color = .blue
            self.camera?.move(toParent: selectedSpace)
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }

    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }

    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif
