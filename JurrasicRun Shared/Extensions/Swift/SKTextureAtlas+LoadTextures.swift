//
//  SKTextureAtlas+LoadTextures.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import SpriteKit

extension SKTextureAtlas {
    func loadTextures() -> [SKTexture] {
        var allTextures: [SKTexture] = []
        for tag in self.textureNames {
            allTextures.append(self.textureNamed(tag))
        }
        return allTextures
    }
}
