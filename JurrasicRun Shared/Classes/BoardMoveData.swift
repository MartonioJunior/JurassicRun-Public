//
//  BoardMoveData.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 04/02/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

class BoardMoveData {
    var tile: GameBoardTile
    var path: GameBoard.PathType?

    init(tile: GameBoardTile, path: GameBoard.PathType?) {
        self.tile = tile
        self.path = path
    }
}
