//
//  GamePausedState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class GamePausedState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: BeforeGameState(), condition: {
                guard let isPaused = self.matchIsPaused() else { return false }
                return !isPaused && self.lastState?.tag() == BeforeGameState().tag()
            }),
            StateTransition(to: DuringGameState(), condition: {
                guard let isPaused = self.matchIsPaused() else { return false }
                return !isPaused && self.lastState?.tag() == DuringGameState().tag()
            }),
            StateTransition(to: AfterGameState(), condition: {
                guard let isPaused = self.matchIsPaused() else { return false }
                return !isPaused && self.lastState?.tag() == AfterGameState().tag()
            })
        ]
    }
}
