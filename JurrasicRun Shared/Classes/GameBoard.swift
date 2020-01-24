//
//  GameBoard.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class GameBoard {
    var graph: GKGraph
    var quadTree: GKQuadtree<SKBoardTile>

    public enum PathType: CaseIterable {
        case yellow
        case blue
        case red

        static var allTypes: Set<PathType> {
            return Set(PathType.allCases)
        }
    }

    public var idTag: UUID
    public var spaces: [GameBoardTile]
    public var availableIDs: [Int] = Array.init(1...500)

    public init() {
        self.graph = GKGraph()
        self.quadTree = GKQuadtree(boundingQuad: GKQuad.create(with: Settings.Scene.limitBounds),
                                   minimumCellSize: Settings.GameplayKit.quadTreeCellSize)
        idTag = UUID()
        spaces = []
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func add(tile: GameBoardTile) {
        tile.idNumber = availableIDs.remove(at: 0)
        spaces.append(tile)
    }

    public func remove(tile: GameBoardTile) {
        guard let index = spaces.firstIndex(where: { (boardTile) -> Bool in
            return boardTile.idNumber == tile.idNumber
        }), let idNumber = tile.idNumber else {
            return
        }
        availableIDs.append(idNumber)
        spaces.remove(at: index)
    }

    public func boardSpace(withID idNumber: Int) -> GameBoardTile? {
        guard let space = spaces.first(where: { (boardTile) -> Bool in
            return boardTile.idNumber == idNumber
        }) else { return nil }
        return space
    }

    public func createPath(from originID: Int, to destinationID: Int, _ type: PathType) {
        guard let originSpace = boardSpace(withID: originID),
            let destinationSpace = boardSpace(withID: destinationID) else { return }
        switch type {
        case .yellow:
            originSpace.yellowPaths.append(destinationSpace)
            destinationSpace.yellowPaths.append(originSpace)
        case .blue:
            originSpace.bluePaths.append(destinationSpace)
            destinationSpace.bluePaths.append(originSpace)
        case .red:
            originSpace.redPaths.append(destinationSpace)
            destinationSpace.redPaths.append(originSpace)
        }
    }

    func configureBoard() {
        for boardSpace in self.spaces {
            boardSpace.setupTile()
            let node = boardSpace.graphNode
            for spacePaths in [boardSpace.redPaths, boardSpace.bluePaths, boardSpace.yellowPaths] {
                for space in spacePaths {
                    addConnection(from: node, to: space.graphNode)
                }
            }
            graph.add([node])
            if let node = boardSpace.node {
                quadTree.add(node, at: node.position.vector2())
            }
        }
    }

    func addConnection(from nodeA: GKGraphNode, to nodeB: GKGraphNode) {
        guard !nodeA.connectedNodes.contains(nodeB) else { return }
        nodeA.addConnections(to: [nodeB], bidirectional: true)
    }
}
