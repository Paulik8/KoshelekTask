//
//  BreedConverterDb.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import RealmSwift

class BreedConverterDb {
    
    func convertFromDb(items: Results<FavouriteItemModel>) -> FavouriteData {
        var initData = FavouriteData()
        items.forEach { itemDb in
            let convertedList: [String] = itemDb.images.toBaseArray(ofType: String.self)
            initData.append(FavouriteItem(breed: itemDb.breed, subbreed: itemDb.subbreed, image: convertedList))
        }
        return initData
    }
    
    func convertToDb() {
    }
    
}
