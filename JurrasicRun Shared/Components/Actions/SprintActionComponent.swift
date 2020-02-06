//
//  SprintActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class SprintActionComponent: PlayerActionComponent, MovementAction {
    var pathBuffer: [BoardMoveData]?
    var isMoving: Bool = false
    init() {
        super.init(named: "Sprint")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) -> Bool {
        guard let target = extraInfo["target"] as? HumanLogicComponent else { return false }
        var newPath = getPath(for: target)
        while newPath.count > 4 { newPath.removeLast() }
        pathBuffer = newPath
        moveHasFinished(success: true)
        return true
    }

    func getPath(for target: HumanLogicComponent) -> [BoardMoveData] {
        guard let player = self.node?.getPlayer(),
            let playerTile = player.currentTile,
            let targetTile = target.currentTile else { return [] }
        return player.getController()?.currentBoard.path(from: playerTile, to: targetTile) ?? []
    }

    override func canAct() -> Bool {
        guard let player = self.node?.getPlayer(), let humans = player.getController()?.humans else { return false }
        return super.canAct() && player.lastAction == nil && humans.contains(where: { !$0.isHidden })
    }

    func moveHasFinished(success: Bool) {
        guard let player = self.node?.getPlayer(), success else { return }
        self.pathBuffer?.removeFirst()
        if self.pathBuffer?.count == 0 {
            self.pathBuffer = nil
            player.applyWait()
        } else if let nextMove = pathBuffer?.first {
            self.move(type: .blue, to: nextMove.tile)
        }
    }
}
