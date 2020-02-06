//
//  PlayerLogicComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 08/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class PlayerLogicComponent: GKComponent {
    public enum Actions {
        case walk
        case run
        case jump
    }

    var type: String = "Player"
    var status: PlayerStatus?
    weak var node: Character?

    public var isHidden: Bool = false {
        didSet {
            self.isHidden ? status?.playerHid(self) : status?.playerRevealed(self)
        }
    }
    public var canJump: Bool = false
    public var onGoal: Bool {
        guard let currentTile = currentTile else {return false}
        return currentTile.terrain == .goal
    }

    public var lastTile: GameBoardTile?
    public var currentTile: GameBoardTile? {
        didSet {
            guard let currentTile = currentTile else { return }
            self.isHidden = currentTile.terrain == .grass && self is HumanLogicComponent && (lastAction == .walk || lastAction == nil)
        }
    }

    public var lastAction: PlayerLogicComponent.Actions? {
        didSet {
            switch lastAction {
            case .run:
                canJump = true
            default:
                canJump = false
            }
        }
    }

    public var amountOfMoves: Int = 0 {
        didSet {
            refillMoves()
        }
    }
    public var movesLeft: Int = 0

    public var yellowMoveCost: Int = 2
    public var blueMoveCost: Int = 2
    public var redMoveCost: Int = 1

    var isPlaying: Bool {
        return GameScene.current.getSKScene()?.controller?.currentPlayer == self
    }

    public func getType() -> String {
        return self.type
    }

    public func spacesAvailable(for pathType: GameBoard.PathType) -> [GameBoardTile]? {
        switch pathType {
        case .yellow:
            return currentTile?.yellowPaths
        case .blue:
            return currentTile?.bluePaths
        case .red:
            return currentTile?.redPaths
        }
    }

    public func pathsAvailable() -> [GameBoard.PathType]? {
        guard let currentTile = currentTile else {return nil}
        var pathOptions: [GameBoard.PathType] = []
        if currentTile.yellowPaths.count > 0 && movesLeft >= yellowMoveCost { pathOptions.append(.yellow) }
        if currentTile.bluePaths.count > 0  && movesLeft >= blueMoveCost { pathOptions.append(.blue) }
        if currentTile.redPaths.count > 0 && movesLeft >= redMoveCost { pathOptions.append(.red) }
        return pathOptions
    }

    public func applyWalk() {
        movesLeft -= yellowMoveCost
        if lastAction == .walk {
            canJump = true
            lastAction = .run
        } else {
            lastAction = .walk
        }
    }

    public func applyRun() {
        movesLeft -= blueMoveCost
        lastAction = .run
        isHidden = false
    }

    public func applyJump() {
        if canJump {
            lastAction = .jump
            isHidden = false
            movesLeft = 0
        }
    }

    public func applyWait() {
        self.status?.noMovesLeft(for: self)
    }

    public func refillMoves() {
        self.movesLeft = self.amountOfMoves
        self.lastAction = nil
        status?.movesWereRefilled(for: self)
    }

    var onTurnEnd: ((GameBoardController) -> Bool)?
    public func checkTurnEnd(on controller: GameBoardController) {
        var continueGame = true
        if let onTurnEnd = onTurnEnd {
            continueGame = onTurnEnd(controller)
        }
        if continueGame {
            controller.nextPlayer()
        }
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor as? Character
    }

    func move(type: GameBoard.PathType, to destination: GameBoardTile, completion: (() -> Void)? = nil) {
        var component: PlayerActionComponent.Type
        switch type {
        case .yellow:
            component = WalkActionComponent.self
        case .blue:
            component = RunActionComponent.self
        case .red:
            component = JumpActionComponent.self
        }
        self.entity()?.getComponent(ofType: component)?.act(extraInfo: [
            "end": destination
        ])
    }

    override func update(deltaTime seconds: TimeInterval) {

    }
}
