//
//  Player+SpriteKitIntegration.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 19/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation
import JurrasicRunBoard

extension Player {
    func getController() -> GameBoardController? {
        return self.delegate as? GameBoardController
    }

    @objc func getAssociatedNode() -> Character? {
        return nil
    }
}
