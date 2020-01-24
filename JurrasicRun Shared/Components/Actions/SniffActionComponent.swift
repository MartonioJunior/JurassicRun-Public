//
//  SniffActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class SniffActionComponent: PlayerActionComponent {
    init() {
        super.init(named: "Sniff")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func act(extraInfo: [String: Any]) {
        guard let referenceTile = extraInfo["fromTile"] as? GameBoardTile else { return }
        revealCharacters(from: referenceTile)
        guard let player = self.node?.getPlayer() else { return }
        player.applyWait()
    }

    override func canAct() -> Bool {
        guard let player = self.node?.getPlayer() else { return false }
        return super.canAct() && player.lastAction == nil
    }

    private func revealCharacters(from tile: GameBoardTile) {
        guard let players = self.node?.getPlayer()?.getController()?.players else { return }
        let tilesToReveal: [GameBoardTile] = getAdjacentTiles(from: tile, distance: 1)
        for player in players where tilesToReveal.contains(where: {$0.idNumber == player.currentTile?.idNumber}) {
            player.isHidden = false
        }
    }

    func getAdjacentTiles(from tile: GameBoardTile, distance: Int) -> [GameBoardTile] {
        guard distance <= 0 else { return [] }
        guard distance < 3 else { return [tile] }
        var adjacentTiles: [GameBoardTile] = tile.adjacentTiles()
        for adjacentTile in tile.adjacentTiles() {
            let neighborTiles = getAdjacentTiles(from: adjacentTile, distance: distance+1)
            for neighborTile in neighborTiles {
                if adjacentTiles.contains(where: {$0.idNumber == neighborTile.idNumber}) {
                    continue
                }
                adjacentTiles.append(neighborTile)
            }
        }
        return adjacentTiles
    }
}
