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
    var selectingTile: Bool = false
    var selectedAction: PlayerActionComponent?

    init(scene: GameScene) {
        self.scene = scene
    }
    // MARK: Pause Menu
    func showPauseMenu(on scene: GameScene) {

    }

    func hidePauseMenu(on scene: GameScene) {

    }

    func selected(action: PlayerActionComponent, on scene: GameScene) {
        selectedAction = action
        self.hideActionMenu(on: scene)
        switch action.name {
        case "Sniff", "Wait":
            action.act(extraInfo: [:])
        case "Sprint":
            guard let randomHuman = self.scene?.controller?.humans.randomElement() else { return }
            action.act(extraInfo: ["target": randomHuman])
        default:
            self.showTileSelectionMenu(on: scene)
        }
    }

    func showActionMenu(on scene: GameScene) {
        guard let player = scene.controller?.currentPlayer?.entity() else { return }
        player.attachComponent(InterfaceComponent(ActionViewController(on: self)))
    }

    func hideActionMenu(on scene: GameScene) {
        guard let player = scene.controller?.currentPlayer?.entity() else { return }
        player.deleteComponent(ofType: InterfaceComponent.self)
    }

    func showTileSelectionMenu(on scene: GameScene) {
        selectingTile = true
    }

    func hideTileSelectionMenu(on scene: GameScene) {
        selectingTile = false
    }

    func showMapDisplayMenu(on scene: GameScene) {

    }

    func hideMapDisplayMenu(on scene: GameScene) {

    }

    func selected(action: String, on scene: GameScene) {
        print(action+" on \(scene)")
    }

    func selected(tile: GameBoardTile, on scene: GameScene) {
        guard let action = selectedAction else { return }
        action.act(extraInfo: ["end": tile])
//        for path in GameBoard.PathType.allTypes {
//            if validTileSelected(tile, for: currentPlayer, on: path) {
//                currentPlayer.move(type: path, to: tile)
//                self.hideTileSelectionMenu(on: scene)
//                break
//            }
//        }
    }

//    func validTileSelected(_ tile: GameBoardTile, for player: PlayerLogicComponent,
//                           on path: GameBoard.PathType) -> Bool {
//        return player.spacesAvailable(for: path)?.contains(where: {$0.idNumber == tile.idNumber}) ?? false
//    }
}
