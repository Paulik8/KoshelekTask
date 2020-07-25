//
//  ImageFavouriteCollectionViewController.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import UIKit

final class ImageFavouriteCollectionViewController: BaseImageCollectionViewController<BreedImages> {
    
    override func initViewModel() {
        viewModel = ImageFavouriteViewModel()
        super.initViewModel()
    }
    
    override func loadData() {
        (viewModel as? ImageViewModelProtocol)?.setData(breed: self.breed, subbreed: self.subbreed)
        super.loadData()
    }
    
    @objc override func likeButtonTapped() {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first,
            let baseViewModel = viewModel,
            let items = baseViewModel.items else { return }
        let item = items[indexPath.row]
        (viewModel as? ImageViewModelProtocol)?.likeButtonTapped(by: item, with: isLikeButtonTapped())
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel,
            let items = viewModel.items else { return cell }
        let item = items[indexPath.row]
        cell.loadImage(by: item, onError: {
            self.viewModel?.error = $0
        })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let baseViewModel = viewModel,
            let _ = baseViewModel.items else { return }
        showAddedLike()
    }
    
    // start ImageCollectionViewControllerDelegate
    
    override func closeView() {
        navigationController?.popViewController(animated: true)
    }
    
    // end
    
}
