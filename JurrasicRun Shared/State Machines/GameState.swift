//
//  GameState.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit
struct StateTransition {
    var destinationStateTag: String?
    var condition: (() -> Bool)?

    init(to destinationState: GameState?, condition: (() -> Bool)?) {
        self.destinationStateTag = destinationState?.tag()
        self.condition = condition
    }
}

class GameState: GKState {
    var connections: [StateTransition]
    weak var lastState: GameState?

    override init() {
        self.connections = []
        super.init()
    }

//    init(with transitions: [StateTransition]) {
//        self.connections = transitions
//        super.init()
//    }

    func tag() -> String? {
        return nil
    }

    func getStateMachine() -> GameStateMachine? {
        return self.stateMachine as? GameStateMachine
    }

    func isValidNextState(_ stateClass: GameState) -> Bool {
        guard let connection = connections.first(where: {
            stateClass.tag() == $0.destinationStateTag
        }) else { return false }
        guard let canChangeState = connection.condition else { return true }
        return canChangeState()
    }

    func didEnter(from previousState: GameState?) {
        self.lastState = previousState
    }

    override func update(deltaTime seconds: TimeInterval) {

    }

    func willExit(to nextState: GameState) {

    }

    func getController() -> GameBoardController? {
        return GameScene.current.getSKScene()?.controller
    }

    func matchIsPaused() -> Bool? {
        return self.getController()?.isPaused
    }

    func matchIsRunning() -> Bool? {
        return self.getController()?.matchIsRunning
    }
}
