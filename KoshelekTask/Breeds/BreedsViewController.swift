//
//  BreedView.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

final class BreedsViewController: BaseCollectionViewController<BreedsArray> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func registerCollectionView() {
        cellIdentifier = "BreedsCellIdentifier"
        collectionView.register(BreedsCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func loadData() {
        (viewModel as? BreedsViewModelProtocol)?.loadData()
    }
    
    override func initViewModel() {
        viewModel = BreedsViewModel()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BreedsCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel,
            let items = viewModel.items else { return cell }
        let index = indexPath.row
        let itemName = items[index].key
        let itemValue = items[index].value
        let subs = itemValue.count == 0 ? nil : itemValue.count
        cell.updateValues(name: itemName, items: subs)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let viewModel = viewModel,
            let items = viewModel.items else { return }
        let subs = items[index].value
        if (subs.isEmpty) {
            let imager = ImageBreedCollectionViewController()
            imager.setBundle(breed: items[index].key, subbreed: nil)
            imager.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(imager, animated: true)
        } else {
            let subbreeds = SubbreedsViewController()
            subbreeds.modalPresentationStyle = .fullScreen
            subbreeds.setBundle(currentBreed: items[index].key, data: subs)
            navigationController?.pushViewController(subbreeds, animated: true)
        }
    }
    
}
