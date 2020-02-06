//
//  Dinosaur.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 09/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

class SKDinosaur: Character {
    override func setupComponents(_ actor: Actor) -> GameEntity? {
        return GameEntity(with: [
            DinosaurLogicComponent(),
            AnimationComponent(animationTags: ["Dinosaur-Run", "Dinosaur-Jump"]),
            WalkActionComponent(),
            RunActionComponent(),
            JumpActionComponent(),
            SniffActionComponent(),
            SprintActionComponent(),
            WaitActionComponent()
        ], for: self)
    }

    override func getPlayer() -> PlayerLogicComponent? {
        return self.entity()?.getComponent(ofType: DinosaurLogicComponent.self)
    }
}
