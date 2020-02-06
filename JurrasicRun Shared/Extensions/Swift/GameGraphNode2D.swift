//
//  GameGraphNode2D.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 03/02/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import GameplayKit

class GameGraphNode2D: GKGraphNode2D {
    init(with point: CGPoint) {
        super.init(point: point.vector2())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
