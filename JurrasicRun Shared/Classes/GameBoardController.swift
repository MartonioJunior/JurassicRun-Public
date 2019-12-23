//
//  GameBoardController.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 19/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import JurrasicRunBoard

class GameBoardController: GameController {
    weak var scene: GameScene?

    override func playerRevealed(_ player: Player) {
        super.playerRevealed(player)
    }

    override func playerHid(_ player: Player) {
        super.playerHid(player)
    }

    override func noMovesLeft(for player: Player) {
        super.noMovesLeft(for: player)
    }

    override func movesWereRefilled(for player: Player) {
        super.movesWereRefilled(for: player)
    }

    override func player(_ player: Player, passed pathType: Board.PathType, to targetTile: BoardTile) {
        guard let playerNode = player.getAssociatedNode(),
            let gameBoardTile = targetTile as? GameBoardTile,
            let tileNode = gameBoardTile.node,
            let playerMovement = playerNode.entity?.component(ofType: MovementComponent.self),
            !playerMovement.isMoving else { return }
        playerMovement.nextTranslation = MovementKind(from: playerNode.scenePosition(), to: tileNode.scenePosition())
        //super.player(player, passed: pathType, to: targetTile)
    }

    override func results(_ type: GameController.Result) {
        super.results(type)
    }

    func attach(to scene: GameScene) {
        self.scene = scene
        scene.controller = self
    }
}
