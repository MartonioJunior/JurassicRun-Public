//
//  HiddenPlayerState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class HiddenPlayerState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: RevealedPlayerState(), condition: {
                return false
            })
        ]
    }
}
