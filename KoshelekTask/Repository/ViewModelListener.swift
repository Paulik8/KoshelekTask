//
//  ViewModelListener.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

protocol ViewModelListener: AnyObject {
    func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool)
}
