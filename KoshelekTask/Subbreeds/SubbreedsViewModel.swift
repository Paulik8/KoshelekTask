//
//  SubbreedsViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 22.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class SubbreedsViewModel: BaseViewModel<Subbreeds>, SubbreedsViewModelProtocol {
    
    var currentBreed: String = ""
    
    func setData(current: String, _ data: Subbreeds) {
        self.currentBreed = current
        self.items = data
    }
    
}
