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
        case interface

        func type() -> GKComponent.Type {
            switch self {
            case .playerLogic:
                return PlayerLogicComponent.self
            case .humanLogic:
                return HumanLogicComponent.self
            case .dinosaurLogic:
                return DinosaurLogicComponent.self
            case .animation:
                return AnimationComponent.self
            case .playerAction:
                return PlayerActionComponent.self
            case .walkAction:
                return WalkActionComponent.self
            case .runAction:
                return RunActionComponent.self
            case .jumpAction:
                return JumpActionComponent.self
            case .sniffAction:
                return SniffActionComponent.self
            case .sprintAction:
                return SprintActionComponent.self
            case .waitAction:
                return WaitActionComponent.self
            case .movement:
                return MovementComponent.self
            case .stateMachine:
                return StateMachineComponent.self
            case .interface:
                return InterfaceComponent.self
            }
        }
    }

    static var allSystems: [GameComponentSystem.Identifier: GameComponentSystem] = {
        var dict: [GameComponentSystem.Identifier: GameComponentSystem] = [:]
        for element in GameComponentSystem.Identifier.allCases {
            dict[element] = GameComponentSystem(element)
        }
        return dict
    }()

    init(_ identifier: GameComponentSystem.Identifier) {
        super.init(componentClass: identifier.type())
    }

    override init() {
        super.init()
    }

    static func getSystem(_ identifier: GameComponentSystem.Identifier) -> GameComponentSystem? {
        return GameComponentSystem.allSystems[identifier]
    }

    static func addComponent(_ component: GKComponent) {
        let systems = GameComponentSystem.allSystems.values.filter {
            return component.isKind(of: $0.componentClass)
        }
        for system in systems {
            system.addComponent(component)
        }
    }

    static func getSystem(ofType componentClass: GKComponent.Type) -> GameComponentSystem? {
        return GameComponentSystem.allSystems.values.first(where: {
            $0.componentClass == componentClass
        })
    }

    static func components<T>(of identifier: GameComponentSystem.Identifier) -> [T]? {
        return GameComponentSystem.getSystem(identifier)?.components as? [T]
    }
}
