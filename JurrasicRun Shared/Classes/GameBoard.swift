//
//  GameBoard.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit
import JurrasicRunBoard

class GameBoard: Board {
    var graph: GKGraph
    var quadTree: GKQuadtree<SKBoardTile>

    override init() {
        self.graph = GKGraph()
        self.quadTree = GKQuadtree(boundingQuad: GKQuad.create(with: Settings.Scene.limitBounds),
                                   minimumCellSize: Settings.GameplayKit.quadTreeCellSize)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureBoard() {
        guard let spaces = self.spaces as? [GameBoardTile] else { return }
        for boardSpace in spaces {
            boardSpace.setupTile()
            let node = boardSpace.graphNode
            for spacePaths in [boardSpace.redPaths, boardSpace.bluePaths, boardSpace.yellowPaths] {
                if let paths = spacePaths as? [GameBoardTile] {
                    for space in paths {
                        addConnection(from: node, to: space.graphNode)
                    }
                }
            }
            graph.add([node])
            if let node = boardSpace.node {
                quadTree.add(node, at: node.scenePosition().vector2())
            }
        }
    }

    func addConnection(from nodeA: GKGraphNode, to nodeB: GKGraphNode) {
        guard !nodeA.connectedNodes.contains(nodeB) else { return }
        nodeA.addConnections(to: [nodeB], bidirectional: true)
    }
}
