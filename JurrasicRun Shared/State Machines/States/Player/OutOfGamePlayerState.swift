//
//  OutOfGamePlayerState.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import UIKit

class OutOfGamePlayerState: GameState {
    override func didEnter(from previousState: GameState?) {
        guard !(previousState is OutOfGamePlayerState) else { return }
        // TODO: Add compliance with Rule System Components
        let newMachine = OutOfTheGameStateMachine(playerIsWinning: false)
        self.getStateMachine()?.component?.entity?.addComponent(StateMachineComponent(machine: newMachine))
    }
}
