//
//  BoardUserData.swift
//  JurrasicRun iOS
//
//  Created by Martônio Júnior on 17/12/19.
//  Copyright © 2019 martonio. All rights reserved.
//

import Foundation

@dynamicMemberLookup
struct BoardUserData {
    var dictionary: [String: String] = [
        "redPaths": "",
        "bluePaths": "",
        "yellowPaths": ""
    ]
    subscript(dynamicMember member: String) -> [Int] {
        let stringValues = dictionary[member]?.components(separatedBy: ",")
        return stringValues?.map {
            return (Int($0) ?? -1)
            } ?? []
    }
}
