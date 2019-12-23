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
        case dinosaurLogic
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
        case .dinosaurLogic:
            super.init(componentClass: DinosaurLogicComponent.self)
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
