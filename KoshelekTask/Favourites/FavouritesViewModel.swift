//
//  FavouritesViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class FavouritesViewModel: BaseViewModel<FavouriteData>, FavouritesViewModelProtocol, ViewModelListener {
    
    let breedsRepository: BreedsRepository = BreedsRepository.shared
    
    // start BaseViewModel
    
    override func loadItems() {
        breedsRepository.getFavouriteItems() {
            self.items = $0
        }
    }
    
    // end
    
    // start FavouritesViewModelProtocol
    
    func setupListener() {
        breedsRepository.viewModelSubscribers.append(self)
    }
    
    // end
    
    // start ViewModelListener
    
    func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool) {
        self.items = breedsRepository.favouriteData
    }
    
    // end
    
}
