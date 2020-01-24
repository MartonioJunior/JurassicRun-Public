//
//  SKNode+Reference.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 23/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import SpriteKit

extension SKNode {
    func removeFromReference() {
        if let ref = self.parent?.parent,
            ref is SKReferenceNode,
            let refParent = ref.parent {
            ref.removeFromParent()
            self.removeFromParent()
            self.position = ref.position
            self.name = ref.name
            self.userData = ref.userData
            refParent.addChild(self)
        }
    }
}
