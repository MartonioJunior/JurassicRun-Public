//
//  SKBoardPaths.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 23/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    static func create(on board: GameBoard, for pathType: GameBoard.PathType) -> SKShapeNode? {
        guard let path = SKShapeNode.generatePath(on: board, for: pathType) else { return nil }
        let node = SKShapeNode(path: path)
        node.setColor(for: pathType)
        return node
    }

    func setColor(for path: GameBoard.PathType) {
        switch path {
        case .blue:
            self.strokeColor = .blue
        case .red:
            self.strokeColor = .red
        case .yellow:
            self.strokeColor = .yellow
        }
    }

    static func generatePath(on board: GameBoard, for type: GameBoard.PathType) -> CGPath? {
        var connections: Set<String> = []
        let path: CGMutablePath = CGMutablePath()
        for space in board.spaces {
            let possiblePaths = space.destinations(for: type)
            for destination in possiblePaths {
                let connectionTag = "\(space.idNumber)-\(destination.idNumber)"
                if connections.contains(connectionTag) { continue }
                connections.insert(connectionTag)
                if let startPosition = space.node?.position,
                    let endPosition = destination.node?.position {
                    path.move(to: startPosition)
                    path.addLine(to: endPosition)
                }
            }
        }
        return path
    }
}
