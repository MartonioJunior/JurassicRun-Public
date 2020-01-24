//
//  PlayerActionComponent.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 07/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class PlayerActionComponent: GKComponent {
    var name: String
    weak var node: Character?
    var isEnabled: Bool = true

    init(named name: String) {
        self.name = name
        super.init()
    }

    override func didAddToEntity() {
        self.node = self.entity()?.actor as? Character
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func act(extraInfo: [String: Any]) {

    }

    func canAct() -> Bool {
        return isEnabled
    }
}
