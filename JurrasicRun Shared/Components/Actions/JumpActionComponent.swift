//
//  JumpActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class JumpActionComponent: PlayerActionComponent {
    init() {
        super.init(named: "Jump")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) {
        guard let destinationTile = extraInfo["end"] as? GameBoardTile, canAct() else {
            return
        }
        guard self.move(type: .red, to: destinationTile), let player = self.node?.getPlayer() else { return }
        player.applyJump()
    }

    override func canAct() -> Bool {
        guard let player = self.node?.getPlayer() else { return false }
        return super.canAct() && player.canJump && player.redMoveCost <= player.movesLeft
    }
}

extension JumpActionComponent: MovementAction {}
