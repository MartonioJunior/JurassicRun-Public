//
//  MovementAction.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 11/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

protocol MovementAction {}

extension MovementAction where Self: PlayerActionComponent {
    @discardableResult
    func move(type: GameBoard.PathType, to tileID: Int) -> Bool {
        guard let player = self.entity()?.getComponent(ofType: PlayerLogicComponent.self),
            let nextSpace = getMove(of: player, to: tileID, of: type) else { return false }
        return self.move(player, type: type, to: nextSpace)
    }

    @discardableResult
    func move(type: GameBoard.PathType, to tile: GameBoardTile) -> Bool {
        guard let player = self.entity()?.getComponent(ofType: PlayerLogicComponent.self) else { return false }
        return self.move(player, type: type, to: tile)
    }

    func move(_ player: PlayerLogicComponent, type: GameBoard.PathType, to tile: GameBoardTile) -> Bool {
        guard let playerNode = player.node,
            let tileNode = tile.node,
            let playerMovement = playerNode.entity()?.getComponent(ofType: MovementComponent.self),
            !playerMovement.isMoving else { return false }
        playerMovement.nextTranslation = MovementKind(from: playerNode.position, to: tileNode.position)
        let animationTag = type != .red ? "Run" : "Jump"
        let animationTime = 0.1
        self.node?.getCameraFocus()
        self.entity()?.getComponent(ofType: AnimationComponent.self)?.runAnimation(
            withTag: animationTag, frameTime: animationTime, completion: { (completed) in
            guard completed else { return }
            self.node?.resignCameraFocus()
            player.status?.player(player, passed: type, to: tile)
        })
        return true
    }

    func getMove(of player: PlayerLogicComponent, to tileID: Int, of type: GameBoard.PathType) -> GameBoardTile? {
        guard let boardPaths = player.spacesAvailable(for: type),
        let nextSpace = boardPaths.first(where: { (boardTile) -> Bool in
            return boardTile.idNumber == tileID
        }) else {
            print("--ERROR-- Path to tile \(tileID) does not exist!")
            return nil
        }
        return nextSpace
    }
}
