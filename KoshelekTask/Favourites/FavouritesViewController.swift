//
//  FavouritesView.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

final class FavouritesViewController: BaseCollectionViewController<FavouriteData> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
    
    override func setupUi() {
        super.setupUi()
    }
    
    override func initViewModel() {
        viewModel = FavouritesViewModel()
        (viewModel as? FavouritesViewModelProtocol)?.setupListener()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BreedsCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel,
            let items = viewModel.items else { return cell }
        let index = indexPath.row
        let item = items[index]
        var name: String
        if let subbreed = item.subbreed {
            name = subbreed
        } else {
            name = item.breed
        }
        cell.updateValues(name: name, items: item.images.count, favourites: true)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imager = ImageFavouriteCollectionViewController()
        guard let baseViewModel = self.viewModel,
            let items = baseViewModel.items else { return }
        let item = items[indexPath.row]
        imager.setBundle(breed: item.breed, subbreed: item.subbreed)
        imager.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(imager, animated: true)
    }
    
}
