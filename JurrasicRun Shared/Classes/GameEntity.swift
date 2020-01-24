//
//  GameEntity.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import GameplayKit

class GameEntity: GKEntity {
    weak var actor: Actor?

    init(with components: [GKComponent], for actor: Actor) {
        super.init()
        self.actor = actor
        for component in components {
            self.addComponent(component)
        }
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        for component in components {
            component.update(deltaTime: seconds)
        }
    }

    func getComponent<ComponentType>(ofType componentClass: ComponentType.Type)
        -> ComponentType? where ComponentType: GKComponent {
        if let component = super.component(ofType: componentClass) { return component }
        return components.first(where: { $0.self.isKind(of: componentClass) }) as? ComponentType
    }
}
