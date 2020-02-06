//
//  MovementAction.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 11/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

protocol MovementAction {
    func moveHasFinished(success: Bool)
}

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

    func move(_ player: PlayerLogicComponent, type: GameBoard.PathType,
              to tile: GameBoardTile) -> Bool {
        guard player.currentTile?.idNumber != tile.idNumber,
            let playerNode = player.node, let tileNode = tile.node else {
                self.moveHasFinished(success: false)
                return false
        }

        // Defining animation settings for move
        let movement = MovementKind(from: playerNode.position, to: tileNode.position)
        let animationTag = getAnimationTag(for: type)
        let animationTime = Settings.Animation.animationTime * Settings.Animation.animationSpeed
        let nodeSpeed = getSpeed(for: player, type: type)

        self.node?.getCameraFocus()
        let animation = self.entity()?.getComponent(ofType: AnimationComponent.self)
        animation?.run(animationTag, with: movement, movementSpeed: nodeSpeed,
                       frameTime: animationTime, loopForever: false) {
            self.node?.resignCameraFocus()
            player.status?.player(player, passed: type, to: tile)
            self.moveHasFinished(success: true)
        }
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

    func getAnimationTag(for type: GameBoard.PathType) -> String {
        switch type {
        case .yellow:
            return "Run"
        case .blue:
            return "Run"
        case .red:
            return "Jump"
        }
    }

    func getSpeed(for player: PlayerLogicComponent, type: GameBoard.PathType) -> Double {
        // Get player's speed
        var playerSpeed: Double
        switch player {
        case is HumanLogicComponent:
            playerSpeed = 60.0
        case is DinosaurLogicComponent:
            playerSpeed = 120.0
        default:
            playerSpeed = 1.0
        }

        // Get action's speed modifier
        var actionModifier: Double
        switch type {
        case .yellow:
            actionModifier = 1.0
        case .blue:
            actionModifier = 2.0
        case .red:
            actionModifier = 5.0
        }
        return playerSpeed * actionModifier * Settings.Animation.animationSpeed
    }
}
