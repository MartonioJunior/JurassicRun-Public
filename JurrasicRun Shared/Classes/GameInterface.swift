//
//  GameInterface.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 18/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

class GameInterface {
    weak var scene: GameScene?

    init(scene: GameScene) {
        self.scene = scene
    }
    // MARK: Pause Menu
    func showPauseMenu(on scene: GameScene) {

    }

    func hidePauseMenu(on scene: GameScene) {

    }

    func selected(action: PlayerActionComponent, on scene: GameScene) {
        self.hideActionMenu(on: scene)
    }

    func showActionMenu(on scene: GameScene) {
        guard let player = scene.controller?.currentPlayer?.entity() else { return }
        player.addComponent(InterfaceComponent(ActionViewController()))
    }

    func hideActionMenu(on scene: GameScene) {
        guard let player = scene.controller?.currentPlayer?.entity() else { return }
        player.removeComponent(ofType: InterfaceComponent.self)
    }

    func showTileSelectionMenu(on scene: GameScene) {

    }

    func hideTileSelectionMenu(on scene: GameScene) {

    }

    func showMapDisplayMenu(on scene: GameScene) {

    }

    func hideMapDisplayMenu(on scene: GameScene) {

    }

    func selected(action: String, on scene: GameScene) {
        print(action+" on \(scene)")
    }

    func selected(tile: GameBoardTile, on scene: GameScene) {
        guard let currentPlayer = scene.controller?.currentPlayer else { return }
        for path in GameBoard.PathType.allTypes {
            if validTileSelected(tile, for: currentPlayer, on: path) {
                currentPlayer.move(type: path, to: tile)
                self.hideTileSelectionMenu(on: scene)
                break
            }
        }
    }

    func validTileSelected(_ tile: GameBoardTile, for player: PlayerLogicComponent,
                           on path: GameBoard.PathType) -> Bool {
        return player.spacesAvailable(for: path)?.contains(where: {$0.idNumber == tile.idNumber}) ?? false
    }
}
