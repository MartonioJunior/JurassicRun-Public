//
//  BeforeGameState.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class BeforeGameState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: DuringGameState(), condition: {
                return self.matchIsRunning() ?? false
            }),
            StateTransition(to: GamePausedState(), condition: {
                return self.matchIsPaused() ?? false
            })
        ]
    }
}
