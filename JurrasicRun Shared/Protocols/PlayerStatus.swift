//
//  PlayerStatus.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 11/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

protocol PlayerStatus {
    func noMovesLeft(for player: PlayerLogicComponent)
    func movesWereRefilled(for player: PlayerLogicComponent)
    func player(_ player: PlayerLogicComponent, passed pathType: GameBoard.PathType, to targetTile: GameBoardTile)
    func playerRevealed(_ player: PlayerLogicComponent)
    func playerHid(_ player: PlayerLogicComponent)
    func player(_ player: PlayerLogicComponent, hasDoneAction action: PlayerActionComponent)
}
