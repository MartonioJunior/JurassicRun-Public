//
//  GameScene+GameInterface.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

extension GameScene: GameInterface {
    func selected(action: String, on scene: GameScene) {
        print(action+" on \(scene)")
    }

    func selected(tile: GameBoardTile, on scene: GameScene) {
        guard let tileID = tile.id else { return }
        scene.controller?.currentPlayer?.walk(to: tileID)
    }
}
