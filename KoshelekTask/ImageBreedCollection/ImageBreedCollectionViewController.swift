//
//  ImageBreedCollectionViewController.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import UIKit

final class ImageBreedCollectionViewController: BaseImageCollectionViewController<BreedApprovedData> {
    
    override func initViewModel() {
        viewModel = ImageBreedViewModel()
        super.initViewModel()
        
    }
    
    @objc override func likeButtonTapped() {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first,
            let baseViewModel = viewModel,
            let items = baseViewModel.items else { return }
        let item = items[indexPath.row]
        (viewModel as? ImageViewModelProtocol)?.likeButtonTapped(by: item.image, with: isLikeButtonTapped())
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel,
            let items = viewModel.items else { return cell }
        let index = indexPath.row
        cell.loadImage(by: items[index].image, onError: {
            self.viewModel?.error = $0
        })
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x == 0.0 || scrollView.contentOffset.x.remainder(dividingBy: collectionView.frame.width) == 0.0) {
            let index = scrollView.contentOffset.x == 0.0 ? 0 : Int(scrollView.contentOffset.x / collectionView.frame.width)
            guard let baseViewModel = viewModel,
                let items = baseViewModel.items else { return }
            let item = items[index]
            (baseViewModel as? ImageViewModelProtocol)?.updateCurrentImageLink(item.image)
            if (item.isLiked) {
                showAddedLike()
            } else {
                showDefaultLike()
            }
        }
    }
    
    // start ImageCollectionViewControllerDelegate
    
    override func closeView() {
    }
    
    // end
    
}
