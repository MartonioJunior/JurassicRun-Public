//
//  HumanLogicComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class HumanLogicComponent: PlayerLogicComponent {
    public override init() {
        super.init()
        type = "Human"
        amountOfMoves = 5
        onTurnEnd = { controller in
            for human in controller.humans {
                if controller.dinosaurs.contains(where: { (dino) -> Bool in
                    return dino.currentTile?.idNumber == human.currentTile?.idNumber
                }) {
                    controller.results(.dinosaursWin)
                    return false
                } else if human.currentTile?.terrain != .goal {
                    return true
                }
            }
            controller.results(.humansWin)
            return false
        }
    }

    static func all() -> [HumanLogicComponent] {
        guard let components = GameComponentSystem.getSystem(.humanLogic)?.components
            as? [HumanLogicComponent] else { return [] }
        return components
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
