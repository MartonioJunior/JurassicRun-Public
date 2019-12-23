//
//  GameInterface.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

protocol GameInterface {
    func selected(tile: GameBoardTile, on scene: GameScene)

    //-- TODO: Change functions to their respective types
    func selected(action: String, on scene: GameScene)
}
