//
//  SKBoardTile.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 17/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit
import JurrasicRunBoard

class SKBoardTile: SKSpriteNode {
    var boardTile: GameBoardTile?
    var type: BoardTile.Terrain { return .normal }
}
