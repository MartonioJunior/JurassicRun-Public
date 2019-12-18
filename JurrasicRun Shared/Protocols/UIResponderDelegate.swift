//
//  UIResponderDelegate.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 06/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import UIKit

protocol UIResponderEvents {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
}
