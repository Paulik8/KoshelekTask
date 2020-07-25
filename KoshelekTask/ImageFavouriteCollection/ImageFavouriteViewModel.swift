//
//  ImageFavouriteViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class ImageFavouriteViewModel: BaseImageViewModel<BreedImages> {
    
    // start ImageViewModelProtocol

    override func likeButtonTapped(by link: String, with tappedState: Bool) {
        currentImageLink = link
        var arr = [String]()
        arr.append(link)
        breedsRepository.removeItemFromFavourites(FavouriteItem(breed: self.breed, subbreed: self.subbreed, image: arr))
    }
    
    // end
    
    // start BaseViewModel
    
    override func loadItems() {
        viewDelegate?.startLoading()
        breedsRepository.getFavouriteItems(by: breed, subbreed: subbreed) {
            self.viewDelegate?.stopLoading()
            self.items = $0
        }
    }
    
    // end
    
    // start ViewModelListener
    
    override func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool) {
        if let images = favouriteImages {
            if (isAdded) {
                self.items = images
            } else {
                vc?.showDefaultLike()
                self.items = images
            }
        } else {
            vc?.showDefaultLike()
            vc?.closeView()
        }
    }
    
    // end
    
}
