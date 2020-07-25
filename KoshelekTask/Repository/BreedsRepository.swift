//
//  BreedsRepository.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import RealmSwift

class BreedsRepository {
    
    static let shared: BreedsRepository = BreedsRepository()
    
    var breedConverter = BreedConverterDb()
    
    var viewModelSubscribers: [ViewModelListener] = []
    var favouriteData: FavouriteData = []
    
    func getFavouriteItems(completion: @escaping (FavouriteData) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            let items = realm.objects(FavouriteItemModel.self)
            self.favouriteData = self.breedConverter.convertFromDb(items: items)
            DispatchQueue.main.async {
                completion(self.favouriteData)
            }
        }
    }
    
    func getFavouriteItems(by breed: String, subbreed: String?, completion: @escaping (BreedImages) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let itemRepository = self.favouriteData.first(where: { $0.breed == breed && $0.subbreed == subbreed }) else { return }
            DispatchQueue.main.async {
                completion(itemRepository.images)
            }
        }
    }
    
    func checkImagesBelongFavourites(breed: String, subbreed: String?, images: BreedImages, completion: @escaping (BreedApprovedData) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            var predicate: NSPredicate
            if let subbreedData = subbreed {
                predicate = NSPredicate(format: "subbreed = %@ AND breed = %@", subbreedData, breed)
            } else {
                predicate = NSPredicate(format: "breed = %@", breed)
            }
            let items = realm.objects(FavouriteItemModel.self).filter(predicate)
            let convertedItem = self.breedConverter.convertFromDb(items: items)
            var approvedData = BreedApprovedData()
            if (convertedItem.count == 0) {
                approvedData = images.map { BreedApprovedImage(image: $0, isLiked: false) }
            } else {
                images.forEach { image in
                    if let firstItem = convertedItem.first {
                        if let _ = firstItem.images.first(where: { $0 == image }) {
                        approvedData.append(BreedApprovedImage(image: image, isLiked: true))
                        } else {
                            approvedData.append(BreedApprovedImage(image: image, isLiked: false))
                        }
                    } else {
                        approvedData.append(BreedApprovedImage(image: image, isLiked: false))
                    }
                }
            }
            DispatchQueue.main.async {
                completion(approvedData)
            }
        }
    }
    
    func addItemToFavourites(_ item: FavouriteItem) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let image = item.images.first else { return }
            let realm = try! Realm()
            var dbItem = FavouriteItemModel()
            var isFinded: Bool
            var finalImages = BreedImages()
            var predicate: NSPredicate
            if let subbreedData = item.subbreed {
                predicate = NSPredicate(format: "subbreed = %@ AND breed = %@", subbreedData, item.breed)
            } else {
                predicate = NSPredicate(format: "breed = %@", item.breed)
            }
            if (!self.favouriteData.isEmpty) {
                var index: Int?
                if let subbreedItem = item.subbreed {
                    index = self.favouriteData.firstIndex(where: { $0.subbreed == subbreedItem && $0.breed == item.breed })
                } else {
                    index = self.favouriteData.firstIndex(where: { $0.breed == item.breed })
                }
                if let findedIndex = index {
                    let resultItems = realm.objects(FavouriteItemModel.self).filter(predicate)
                    guard let _dbItem = resultItems.first else { return }
                    dbItem = _dbItem
                    isFinded = true
                    self.favouriteData[findedIndex].images.append(image)
                    finalImages = self.favouriteData[findedIndex].images
                } else {
                    isFinded = false
                }
            } else {
                isFinded = false
            }
            if (!isFinded) {
                finalImages = item.images
                dbItem = self.addNewItem(item: item)
            }
            
            try! realm.write {
                !isFinded ? realm.add(dbItem) : dbItem.images.append(image)
            }
            self.updateData(favouriteImages: finalImages, image: image, isAdded: true)
        }
    }
    
    func removeItemFromFavourites(_ item: FavouriteItem) {
        guard let image = item.images.first else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            let realm = try! Realm()
            var finalImages: BreedImages?
            var predicate: NSPredicate
            if let subbreedData = item.subbreed {
                predicate = NSPredicate(format: "subbreed = %@ AND breed = %@", subbreedData, item.breed)
            } else {
                predicate = NSPredicate(format: "breed = %@", item.breed)
            }
            guard let itemImagesIndex = self.favouriteData.firstIndex(where: { $0.breed == item.breed && $0.subbreed == item.subbreed }) else { return }
            let indexInt = Int(itemImagesIndex)
            guard let findedIndex = self.favouriteData[indexInt].images.firstIndex(where: { $0 == image }) else { return }
            let findedIndexInt = Int(findedIndex)
            self.favouriteData[indexInt].images.remove(at: findedIndexInt)
            let items = realm.objects(FavouriteItemModel.self).filter(predicate)
            if let itemDb = items.first {
                if (self.favouriteData[indexInt].images.isEmpty) {
                    self.favouriteData.remove(at: indexInt)
                    try! realm.write {
                        realm.delete(itemDb)
                    }
                } else {
                    finalImages = self.favouriteData[indexInt].images
                    try! realm.write {
                        if let index = itemDb.images.firstIndex(of: image) {
                            itemDb.images.remove(at: index)
                        }
                    }
                }
                
            }
            self.updateData(favouriteImages: finalImages, image: image, isAdded: false)
        }
    }
    
    private func addNewItem(item: FavouriteItem) -> FavouriteItemModel {
        let dbItem = FavouriteItemModel()
        dbItem.id = UUID().uuidString
        dbItem.breed = item.breed
        dbItem.subbreed = item.subbreed
        dbItem.images.append(item.images.first!)
        favouriteData.append(item)
        return dbItem
    }
    
    private func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool) {
        DispatchQueue.main.async {
            self.viewModelSubscribers.forEach { $0.updateData(favouriteImages: favouriteImages, image: image, isAdded: isAdded) }
        }
    }
    
}
