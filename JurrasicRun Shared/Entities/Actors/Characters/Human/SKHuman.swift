//
//  Human.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 09/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

class SKHuman: Character {
    override func setupComponents(_ actor: Actor) -> GameEntity? {
        return GameEntity(with: [
            HumanLogicComponent(),
            AnimationComponent(animationTags: ["Human-Run", "Human-Jump"]),
            WalkActionComponent(),
            RunActionComponent(),
            JumpActionComponent(),
            WaitActionComponent()
        ], for: self)
    }

    override func getPlayer() -> PlayerLogicComponent? {
        return self.entity()?.getComponent(ofType: HumanLogicComponent.self)
    }
}
