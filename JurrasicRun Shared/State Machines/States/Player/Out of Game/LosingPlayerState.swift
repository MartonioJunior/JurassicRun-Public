//
//  LosingPlayerState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class LosingPlayerState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: WonPlayerState(), condition: {
                return false
            }),
            StateTransition(to: LostPlayerState(), condition: {
                return false
            })
        ]
    }
}
