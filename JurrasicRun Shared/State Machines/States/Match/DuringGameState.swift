//
//  DuringGameState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class DuringGameState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: AfterGameState(), condition: {
                return !(self.matchIsRunning() ?? true)
            }),
            StateTransition(to: GamePausedState(), condition: {
                return self.matchIsPaused() ?? false
            })
        ]
    }
}
