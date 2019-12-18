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

    func loadBoard() {
        guard let scene = self.rootNode as? GameScene else { return }
        guard let spaces = self.getAllNodes().filter({
            return $0 is SKBoardTile
        }) as? [SKBoardTile] else { return }
        let board = GameBoard()
        for tileNode in spaces {
            tileNode.boardTile = GameBoardTile(for: tileNode, in: board)
        }
        board.setupGraph()
        scene.board = board
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
