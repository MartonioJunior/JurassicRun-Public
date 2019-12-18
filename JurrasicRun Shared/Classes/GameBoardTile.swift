//
//  GameBoardTile.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 17/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit
import JurrasicRunBoard

class GameBoardTile: BoardTile {
    var graphNode: GKGraphNode2D
    weak var node: SKBoardTile?

    override init(with terrain: BoardTile.Terrain, in board: Board) {
        self.graphNode = GKGraphNode2D()
        super.init(with: terrain, in: board)
    }

    init(for node: SKBoardTile, in board: GameBoard) {
        let reference = node.parent?.parent ?? node
        let point = reference.position
        self.node = node
        self.graphNode = GKGraphNode2D.create(with: point)
        super.init(with: node.type, in: board)
    }

    func setupTile() {
        // Configure BoardTile connections
        let reference = node?.parent?.parent ?? node
        guard let dict = reference?.userData as? [String: String],
            let board = board else { return }
        let pathData = BoardUserData(dictionary: dict)
        join(pathsOn: board, ofType: .red, forTiles: pathData.redPaths)
        join(pathsOn: board, ofType: .blue, forTiles: pathData.bluePaths)
        join(pathsOn: board, ofType: .yellow, forTiles: pathData.yellowPaths)
    }

    func join(pathsOn board: Board, ofType pathType: Board.PathType, forTiles tileIDs: [Int]) {
        guard let currentID = self.id else { return }
        for destinationID in tileIDs {
            board.createPath(from: currentID, to: destinationID, pathType)
        }
    }
}
