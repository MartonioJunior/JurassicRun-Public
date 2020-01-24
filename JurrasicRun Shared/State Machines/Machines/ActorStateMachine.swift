//
//  ActorStateMachine.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class ActorStateMachine: GameStateMachine {
    init() {
        super.init(states: [
            ActiveActorState(),
            InactiveActorState(),
            PausedActorState()
        ])
    }
}
