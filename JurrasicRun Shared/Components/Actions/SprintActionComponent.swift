//
//  SprintActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class SprintActionComponent: PlayerActionComponent {
    init() {
        super.init(named: "Sprint")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) {

    }

    override func canAct() -> Bool {
        return super.canAct()
    }
}

extension SprintActionComponent: MovementAction {}
