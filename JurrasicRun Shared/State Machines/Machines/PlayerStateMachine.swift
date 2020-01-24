//
//  PlayerStateMachine.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class PlayerStateMachine: GameStateMachine {
    init() {
        super.init(states: [
            ActingPlayerState(),
            WaitingPlayerState(),
            OutOfGamePlayerState()
        ])
    }
}
