//
//  DinosaurLogicComponent.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class DinosaurLogicComponent: PlayerLogicComponent {
    public var isSprinting = false {
        didSet {
            amountOfMoves = isSprinting ? 7 : 5
        }
    }

    public override init() {
        super.init()
        type = "Dinosaur"
        amountOfMoves = 5
        onTurnEnd = { controller in
            for human in controller.humans {
                if let humanID = human.currentTile?.idNumber,
                    let dinosaurID = self.currentTile?.idNumber,
                        humanID == dinosaurID,
                    human.currentTile?.terrain != .goal {
                    controller.results(.dinosaursWin)
                    return false
                }
            }
            return true
        }
    }

    static func all() -> [DinosaurLogicComponent] {
        guard let components = GameComponentSystem.getSystem(.dinosaurLogic)?.components
            as? [DinosaurLogicComponent] else { return [] }
        return components
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime time: TimeInterval) {

    }

    public func toggleSprint() {
        isSprinting = !isSprinting
    }
}
