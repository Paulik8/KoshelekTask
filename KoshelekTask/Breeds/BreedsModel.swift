//
//  BreedsModel.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

struct BreedsResponse: Codable {
    let message: BreedsData
    let status: String
}

typealias BreedsData = [String: [String]]
typealias BreedsArray = [(key: String, value: [String])]

typealias Subbreeds = [String]

