//
//  JumpActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class JumpActionComponent: PlayerActionComponent, MovementAction {
    init() {
        super.init(named: "Jump")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) -> Bool {
        guard let destinationTile = extraInfo["end"] as? GameBoardTile, canAct() else { return false }
        let actionDone = self.move(type: .red, to: destinationTile)
        return actionDone
    }

    override func canAct() -> Bool {
        guard let player = self.node?.getPlayer() else { return false }
        return super.canAct() && player.canJump && player.redMoveCost <= player.movesLeft
            && player.pathsAvailable()?.contains(.red) == true
    }

    func moveHasFinished(success: Bool) {
        guard let player = self.node?.getPlayer(), success else { return }
        player.applyJump()
        player.status?.player(player, hasDoneAction: self)
    }
}
