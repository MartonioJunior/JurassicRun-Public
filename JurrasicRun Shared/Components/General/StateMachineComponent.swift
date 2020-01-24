//
//  StateMachineComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class StateMachineComponent: GKComponent {
    var stateMachine: GameStateMachine
    var currentState: GameState? {
        return stateMachine.getCurrentState()
    }
    weak var node: Actor?

    init(machine: GameStateMachine) {
        self.stateMachine = machine
        super.init()
        self.stateMachine.component = self
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor
    }

    convenience init(states: [GameState]) {
        self.init(machine: GameStateMachine(states: states))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {

    }
}
