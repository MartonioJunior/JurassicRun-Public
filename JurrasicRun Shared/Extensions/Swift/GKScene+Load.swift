//
//  GKScene+Load.swift
//  JurrasicRun Shared
//
//  Created by Martônio Júnior on 27/09/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit
import GameplayKit

extension GKScene {
    static func loadScene(number: Int) -> GKScene {
        let fileName = "GameScene\(number)"
        let scene = GKScene()
        guard let skScene = SKScene(fileNamed: fileName) as? GameScene else {
            return scene
        }
        skScene.connectTo(scene)
        return scene
    }

    func loadGame() {
        guard let scene = self.rootNode as? GameScene else { return }
        // Get all scene nodes
        let allNodes = self.getAllNodes()

        // Setup board
        guard let spaces = allNodes.filter({
            return $0 is SKBoardTile
        }) as? [SKBoardTile] else { return }
        let board = GameBoard()
        for tileNode in spaces {
            tileNode.boardTile = GameBoardTile(for: tileNode, in: board)
        }
        board.configureBoard()
        for path in [GameBoard.PathType.blue, GameBoard.PathType.yellow, GameBoard.PathType.red] {
            if let pathNode = SKShapeNode.create(on: board, for: path) {
                scene.addChild(pathNode)
            }
        }

        // Attach players to their spaces
        if let players = allNodes.filter({
            return $0 is Character
        }) as? [Character] {
            for character in players {
                if let overlappingTile = spaces.first(where: {
                    return $0.scenePosition().distance(to: character.scenePosition()) < 1
                    })?.boardTile {
                    character.getPlayer()?.currentTile = overlappingTile
                }
            }
        }

        scene.board = board

        // Setup Component System
        for node in allNodes {
            if let entity = node.entity {
                for system in GameComponentSystem.allSystems.values {
                    system.addComponent(foundIn: entity)
                }
            }
        }

        // Load Game Controller
        let controller = GameBoardController()
        let humans = PlayerLogicComponent.allHumans()
        let dinosaurs = DinosaurLogicComponent.allDinosaurs()
        controller.load(board, humans: humans, dinosaurs: dinosaurs)
        controller.attach(to: scene)
    }

    func getAllNodes() -> [SKNode] {
        var nodes: [SKNode] = []
        guard let sceneNode = self.rootNode as? GameScene else { return [] }
        self.load(node: sceneNode, to: &nodes)
        return nodes
    }

    func load(node: SKNode, to nodes: inout [SKNode]) {
        if node.children.count == 0 {
            nodes.append(node)
        } else {
            for childNode in node.children {
                load(node: childNode, to: &nodes)
            }
        }
    }
}
