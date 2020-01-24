//
//  GameStateMachine.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class GameStateMachine: GKStateMachine {
    weak var component: StateMachineComponent?
    init(states: [GameState]) {
        super.init(states: states)
    }

    func getCurrentState() -> GameState? {
        return self.currentState as? GameState
    }

    func canEnterState(_ state: GameState) -> Bool {
        guard let connection = self.getCurrentState()?.connections.first(where: {
            $0.destinationStateTag == state.tag()
        }), let canEnter = connection.condition else { return false }
        return canEnter()
    }

    @discardableResult
    func enter(_ state: GameState) -> Bool {
        guard self.canEnterState(state) else { return false }
        let stateType = type(of: state)
        return super.enter(stateType)
    }

    override func update(deltaTime: TimeInterval) {

    }
}
