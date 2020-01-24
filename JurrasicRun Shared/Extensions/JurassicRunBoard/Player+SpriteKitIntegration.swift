//
//  Player+SpriteKitIntegration.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 19/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

extension PlayerLogicComponent {
    func getController() -> GameBoardController? {
        return self.status as? GameBoardController
    }
}
