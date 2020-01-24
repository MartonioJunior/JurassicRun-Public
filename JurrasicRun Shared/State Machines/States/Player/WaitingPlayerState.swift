//
//  WaitingPlayerState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import UIKit

class WaitingPlayerState: GameState {
    override init() {
        super.init()
        self.connections = [
            StateTransition(to: ActingPlayerState(), condition: {
                return false
            }),
            StateTransition(to: OutOfGamePlayerState(), condition: {
                return false
            })
        ]
    }
}
