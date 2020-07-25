//
//  ImageModel.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import RealmSwift

struct ImageResponse: Codable {
    let message: BreedImages
    let status: String
}

typealias BreedImages = [String]

struct BreedApprovedImage {
    var image: String
    var isLiked: Bool
}

typealias BreedApprovedData = [BreedApprovedImage]

struct FavouriteItem {
    
    let breed: String
    var subbreed: String? = nil
    var images: [String] = []
    
    init(breed: String, subbreed: String?, image: [String]) {
        self.breed = breed
        self.images = image
        guard let subbreedData = subbreed else { return }
        self.subbreed = subbreedData
    }
    
}

typealias FavouriteData = [FavouriteItem]

class FavouriteItemModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var breed: String = ""
    @objc dynamic var subbreed: String? = nil
    let images = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension List {
    func toBaseArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
