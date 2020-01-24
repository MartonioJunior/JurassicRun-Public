//
//  GameComponentSystem.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class GameComponentSystem: GKComponentSystem<GKComponent> {
    enum Identifier: CaseIterable {
        case playerLogic
        case humanLogic
        case dinosaurLogic
        case animation
        case playerAction
        case walkAction
        case runAction
        case jumpAction
        case sniffAction
        case sprintAction
        case waitAction
        case movement
        case stateMachine
    }

    static var allSystems: [GameComponentSystem.Identifier: GameComponentSystem] = {
        var dict: [GameComponentSystem.Identifier: GameComponentSystem] = [:]
        for element in GameComponentSystem.Identifier.allCases {
            dict[element] = GameComponentSystem(element)
        }
        return dict
    }()

    init(_ identifier: GameComponentSystem.Identifier) {
        switch identifier {
        case .playerLogic:
            super.init(componentClass: PlayerLogicComponent.self)
        case .humanLogic:
            super.init(componentClass: HumanLogicComponent.self)
        case .dinosaurLogic:
            super.init(componentClass: DinosaurLogicComponent.self)
        case .animation:
            super.init(componentClass: AnimationComponent.self)
        case .playerAction:
            super.init(componentClass: PlayerActionComponent.self)
        case .walkAction:
            super.init(componentClass: WalkActionComponent.self)
        case .runAction:
            super.init(componentClass: RunActionComponent.self)
        case .jumpAction:
            super.init(componentClass: JumpActionComponent.self)
        case .sniffAction:
            super.init(componentClass: SniffActionComponent.self)
        case .sprintAction:
            super.init(componentClass: SprintActionComponent.self)
        case .waitAction:
            super.init(componentClass: WaitActionComponent.self)
        case .movement:
            super.init(componentClass: MovementComponent.self)
        case .stateMachine:
            super.init(componentClass: StateMachineComponent.self)
        }
    }

    override init() {
        super.init()
    }

    static func getSystem(_ identifier: GameComponentSystem.Identifier) -> GameComponentSystem? {
        return GameComponentSystem.allSystems[identifier]
    }

    static func components<T>(of identifier: GameComponentSystem.Identifier) -> [T]? {
        return GameComponentSystem.getSystem(identifier)?.components as? [T]
    }
}
