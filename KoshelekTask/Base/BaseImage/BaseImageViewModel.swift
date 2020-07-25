//
//  BaseImageViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class BaseImageViewModel<T:Collection>: BaseViewModel<T>, ImageViewModelProtocol, ViewModelListener {
    
    weak var vc: ImageCollectionViewControllerDelegate?
    
    let breedsRepository: BreedsRepository = BreedsRepository.shared
    var breedService = BreedService()
    var breed: String = ""
    var subbreed: String?
    var currentImageLink: String = ""
    
    // start ImageViewModelProtocol
    
    func updateCurrentImageLink(_ link: String) {
        currentImageLink = link
    }
    
    func setData(breed: String, subbreed: String?) {
        self.breed = breed
        self.subbreed = subbreed
    }
    
    func likeButtonTapped(by link: String, with tappedState: Bool) { // 1
    }
    
    func setupListener() {
        breedsRepository.viewModelSubscribers.append(self)
    }
    
    // end
    
    // start BaseViewModel
    
    override func loadItems() {
    }
    
    // end
    
    // start ViewModelListener
    
    func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool) {
    }
    
    // end
    
}
