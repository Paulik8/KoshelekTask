//
//  ImageBreedViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class ImageBreedViewModel: BaseImageViewModel<BreedApprovedData> {
    
    private func changeTriggeredItem(image: String, likeState: Bool) {
        guard let items = self.items else { return }
        guard let findedIndex = items.firstIndex(where: { $0.image == image }) else { return }
        self.items?[findedIndex].isLiked = likeState
    }
    
    // start ImageViewModelProtocol
    
    override func likeButtonTapped(by link: String, with tappedState: Bool) {
        var arr = [String]()
        arr.append(link)
        if (tappedState) {
            breedsRepository.removeItemFromFavourites(FavouriteItem(breed: self.breed, subbreed: self.subbreed, image: arr))
        } else {
            breedsRepository.addItemToFavourites(FavouriteItem(breed: self.breed, subbreed: self.subbreed, image: arr))
        }
        
    }
    
    // end
    
    // start BaseViewModel
    
    override func loadItems() {
        viewDelegate?.startLoading()
        breedService.loadImagesByBreed(by: self.breed, subbreed: self.subbreed, onSuccess: {
            self.breedsRepository.checkImagesBelongFavourites(breed: self.breed, subbreed: self.subbreed, images: $0) {
                    self.viewDelegate?.stopLoading()
                    self.items = $0
                if (!$0.isEmpty) {
                    self.viewDelegate?.scrollToFirstItem()
                }
            }
        },
            onError: {
                self.viewDelegate?.stopLoading()
                self.error = $0
        })
    }
    
    // end
    
    // start ViewModelListener
    
    override func updateData(favouriteImages: BreedImages?, image: String, isAdded: Bool) {
        changeTriggeredItem(image: image, likeState: isAdded)
        if (currentImageLink == image) {
            isAdded ? vc?.showAddedLike() : vc?.showDefaultLike()
        } else {
            
        }
    }
    
    // end
    
}
