//
//  GameBoardTile.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 17/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class GameBoardTile {
    var graphNode: GameGraphNode2D
    weak var node: SKBoardTile?
    public enum Terrain: String {
        case normal
        case grass
        case mud
        case goal
    }

    public var tilePosition: CGPoint?
    public var terrain: Terrain
    public var board: GameBoard?
    public var idNumber: Int?
    public var yellowPaths: [GameBoardTile]
    public var bluePaths: [GameBoardTile]
    public var redPaths: [GameBoardTile]

    public var description: String {
        guard let idNumber = idNumber else { return "" }
        return "ID: \(idNumber)"
    }

    public var fullDescription: String {
        var spaceString = description
        spaceString += "\nType: \(terrain.rawValue)"
        spaceString += "\nWalk to: |"
        for path in yellowPaths {
            spaceString += "S\(path.description)|"
        }
        spaceString += "\nRun to: |"
        for path in bluePaths {
            spaceString += "S\(path.description)|"
        }
        spaceString += "\nJump to: |"
        for path in redPaths {
            spaceString += "S\(path.description)|"
        }
        return spaceString+"|"
    }

    private init(with terrain: Terrain, in board: GameBoard) {
        self.graphNode = GameGraphNode2D(with: .zero)
        self.terrain = terrain
        self.bluePaths = []
        self.yellowPaths = []
        self.redPaths = []
        self.board = board
        board.add(tile: self)
    }

    convenience init(for node: SKBoardTile, in board: GameBoard) {
        self.init(with: node.type, in: board)
        self.node = node
        self.graphNode = GameGraphNode2D(with: node.position)
    }

    func setupTile() {
        // Configure BoardTile connections
        guard let dict = node?.userData as? [String: String],
            let board = board else { return }
        let pathData = BoardUserData(dictionary: dict)
        join(pathsOn: board, ofType: .red, forTiles: pathData.redPaths)
        join(pathsOn: board, ofType: .blue, forTiles: pathData.bluePaths)
        join(pathsOn: board, ofType: .yellow, forTiles: pathData.yellowPaths)
    }

    func join(pathsOn board: GameBoard, ofType pathType: GameBoard.PathType, forTiles tileIDs: [Int]) {
        guard let currentID = self.idNumber else { return }
        for destinationID in tileIDs {
            board.createPath(from: currentID, to: destinationID, pathType)
        }
    }

    func adjacentTiles() -> [GameBoardTile] {
        var adjacentTiles: [GameBoardTile] = []
        for item in redPaths+bluePaths+yellowPaths {
            if adjacentTiles.contains(where: {$0.idNumber == item.idNumber}) {
                continue
            }
            adjacentTiles.append(item)
        }
        return adjacentTiles
    }

    func destinations(for pathType: GameBoard.PathType) -> [GameBoardTile] {
        switch pathType {
        case .red:
            return redPaths
        case .blue:
            return bluePaths
        case .yellow:
            return yellowPaths
        }
    }

    func path(for tile: GameBoardTile) -> GameBoard.PathType? {
        if redPaths.contains(where: { $0.idNumber == tile.idNumber }) { return .red }
        if yellowPaths.contains(where: { $0.idNumber == tile.idNumber }) { return .yellow }
        if bluePaths.contains(where: { $0.idNumber == tile.idNumber }) { return .blue }
        return nil
    }
}
