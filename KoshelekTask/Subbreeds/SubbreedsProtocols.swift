//
//  SubbreedsProtocols.swift
//  KoshelekTask
//
//  Created by Paulik on 22.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

protocol SubbreedsViewModelProtocol {
    
    var currentBreed: String { get set }
    func setData(current: String, _ data: Subbreeds)
    
}
