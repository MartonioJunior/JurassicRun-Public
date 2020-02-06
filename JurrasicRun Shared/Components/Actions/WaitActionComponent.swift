//
//  WaitActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 08/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class WaitActionComponent: PlayerActionComponent {
    init() {
        super.init(named: "Wait")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) -> Bool {
        guard let player = self.node?.getPlayer() else { return false }
        player.applyWait()
        return true
    }

    override func canAct() -> Bool {
        guard let player = self.node?.getPlayer() else { return false }
        return super.canAct() && player.movesLeft > 0
    }
}
