//
//  OutOfTheGameStateMachine.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class OutOfTheGameStateMachine: GameStateMachine {
    init(playerIsWinning: Bool) {
        let winningState = WinningPlayerState()
        let losingState = LosingPlayerState()
        super.init(states: [
            winningState,
            losingState,
            WonPlayerState(),
            LosingPlayerState()
        ])
        let nextState: GameState = playerIsWinning ? winningState : losingState
        self.enter(nextState)
    }
}
