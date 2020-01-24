//
//  RevealedPlayerState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

class RevealedPlayerState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: HiddenPlayerState(), condition: {
                return false
            })
        ]
    }
}
