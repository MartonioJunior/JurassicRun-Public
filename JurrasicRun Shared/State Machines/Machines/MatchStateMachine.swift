//
//  MatchStateMachine.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import UIKit

class MatchStateMachine: GameStateMachine {
    init() {
        super.init(states: [
            GamePausedState(),
            BeforeGameState(),
            DuringGameState(),
            AfterGameState()
        ])
    }
}
