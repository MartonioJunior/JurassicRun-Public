//
//  SKViewCode.swift
//  JurrasicRun
//
//  Created by Martônio Júnior on 24/01/20.
//  Copyright © 2020 martonio. All rights reserved.
//

import Foundation

protocol ViewCode {
    func setupConstraints()
    func buildViewHierarchy()
    func configureAdditionalInformation()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        configureAdditionalInformation()
    }
}
