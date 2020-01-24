//
//  GameBoardController.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 19/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit

class GameBoardController: PlayerStatus {
    var isPaused: Bool = false
    var matchIsRunning: Bool = false
    weak var scene: GameScene?
    public enum Result {
        case dinosaursWin
        case humansWin
        case tie
    }

    public var currentBoard: GameBoard!
    public var currentPlayer: PlayerLogicComponent? {
        return self.players[self.currentPlayerIndex]
    }
    public var currentPlayerIndex: Int = 0
    public var turnNumber: Int = 0
    public var players: [PlayerLogicComponent] = []
    public var humans: [HumanLogicComponent] {
        return HumanLogicComponent.all()
//        return players.filter {
//            return $0 is HumanLogicComponent
//        } as! [HumanLogicComponent]
    }
    public var dinosaurs: [DinosaurLogicComponent] {
        return DinosaurLogicComponent.all()
//        return players.filter {
//            return $0 is DinosaurLogicComponent
//        } as! [DinosaurLogicComponent]
    }

    public init() {}

//    public func load(_ board: GameBoard, amountOfHumans: Int = 1, amountOfDinosaurs: Int = 1) {
//        self.currentBoard = board
//        for _ in 0..<amountOfHumans {
//            players.append(Human())
//        }
//        for _ in 0..<amountOfDinosaurs {
//            players.append(Dinosaur())
//        }
//        players.first?.delegate = self
//        for player in players {
//            player.currentTile = board.spaces.shuffled().first
//        }
//        reset()
//    }

    public func load(_ board: GameBoard, humans: [HumanLogicComponent] = HumanLogicComponent.all(),
                     dinosaurs: [DinosaurLogicComponent] = DinosaurLogicComponent.all()) {
        self.currentBoard = board
        players.append(contentsOf: humans)
        players.append(contentsOf: dinosaurs)
        players.first?.status = self
        reset()
    }

    public func reset() {
        turnNumber = 1
    }

    public func nextPlayer() {
        players[currentPlayerIndex].status = nil
        currentPlayerIndex += 1
        if currentPlayerIndex == players.count {
            nextTurn()
            players.first?.status = self
        } else {
            let player = players[currentPlayerIndex]
            player.status = self
        }
    }

    public func nextTurn() {
        turnNumber += 1
        currentPlayerIndex = 0
        for player in players {
            player.refillMoves()
        }
//        BoardTester.current.addToLog(info: "Turn \(turnNumber)")
    }

    func results(_ type: GameBoardController.Result) {
        var text: String
        switch type {
        case .dinosaursWin:
            text = "Dinosaurs Win"
        case .humansWin:
            text = "Humans Win"
        case .tie:
            text = "It's a Tie"
        }
        guard let scene = self.scene, let camera = scene.camera() else { return }
        let label = SKLabelNode.mainTitle(with: text)
        label.position = .zero
        label.alpha = 0
        camera.addChild(label)
        label.show(fadeIn: 0.5, wait: 3.0, fadeOut: 0, completion: nil)
    }

    func playerRevealed(_ player: PlayerLogicComponent) {
        player.entity()?.actor?.run(SKAction.fadeAlpha(to: 1.0, duration: 0.5))
    }

    func playerHid(_ player: PlayerLogicComponent) {
        player.entity()?.actor?.run(SKAction.fadeAlpha(to: 0.5, duration: 0.5))
    }

    func noMovesLeft(for player: PlayerLogicComponent) {
        // Interface sequence for next turn
        self.nextPlayer()
        guard let scene = self.scene else { return }
        Transitions.pan(to: player, on: scene)
    }

    func movesWereRefilled(for player: PlayerLogicComponent) {

    }

    func player(_ player: PlayerLogicComponent, passed pathType: GameBoard.PathType, to targetTile: GameBoardTile) {
        player.lastTile = player.currentTile
        player.currentTile = targetTile
        if player.movesLeft <= 0 {
            player.status?.noMovesLeft(for: player)
        }
    }

    func attach(to scene: GameScene) {
        self.scene = scene
        scene.controller = self
    }
}
