//
//  InactiveActorState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class InactiveActorState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: ActiveActorState(), condition: {
                return false
            }),
            StateTransition(to: PausedActorState(), condition: {
                return false
            })
        ]
    }
}
