//
//  SubbreedsViewController.swift
//  KoshelekTask
//
//  Created by Paulik on 22.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

final class SubbreedsViewController: BaseCollectionViewController<Subbreeds> {
    
    var subbreeds: Subbreeds = []
    var breed: String = ""
    
    func setBundle(currentBreed: String, data: Subbreeds) {
        self.subbreeds = data
        self.breed = currentBreed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initViewModel() {
        viewModel = SubbreedsViewModel()
        viewModel?.items = subbreeds
    }
    
    override func loadData() {
        (viewModel as? SubbreedsViewModelProtocol)?.setData(current: self.breed, subbreeds)
    }
    
    override func setupUi() {
        title = breed
        super.setupUi()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? BreedsCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel,
            let items = viewModel.items else { return cell }
        let index = indexPath.row
        cell.updateValues(name: items[index])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imager = ImageBreedCollectionViewController()
        guard let subbreedViewModel = self.viewModel as? SubbreedsViewModelProtocol,
            let baseViewModel = self.viewModel,
            let items = baseViewModel.items else { return }
        imager.setBundle(breed: subbreedViewModel.currentBreed, subbreed: items[indexPath.row])
        imager.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(imager, animated: true)
    }
    
}
