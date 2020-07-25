//
//  BaseImageCollectionViewController.swift
//  KoshelekTask
//
//  Created by Paulik on 24.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation
import UIKit

class BaseImageCollectionViewController<T:Collection>: BaseCollectionViewController<T>, ImageCollectionViewControllerDelegate {
    
    var breed: String = ""
    var subbreed: String?
    
    lazy var likeButton: UIImageView = {
        let liker = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
        liker.image = UIImage(named: "like")
        liker.isUserInteractionEnabled = true
        liker.translatesAutoresizingMaskIntoConstraints = false
        return liker
    }()
    
    func setBundle(breed: String, subbreed: String?) {
        self.breed = breed
        guard let subbreedData = subbreed else { return }
        self.subbreed = subbreedData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationItem.rightBarButtonItem = nil
        super.viewDidDisappear(animated)
    }
    
    override func initViewModel() {
        guard let viewModelDelegate = viewModel as? ImageViewModelProtocol else { return }
        viewModelDelegate.vc = self
        viewModelDelegate.setupListener()
        
    }
    
    override func loadData() {
        (viewModel as? ImageViewModelProtocol)?.setData(breed: self.breed, subbreed: self.subbreed)
        super.loadData()
    }
    
    override func setupCollectionView() {
        isCollectionVertical = false
        super.setupCollectionView()
    }
    
    override func registerCollectionView() {
        cellIdentifier = "ImageCellIdentifier"
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func setupUi() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .done
            , target: self, action: #selector(shareTapped))
        if let subbreedData = subbreed {
            title = subbreedData
        } else {
            title = breed
        }
        super.setupUi()
        view.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            likeButton.widthAnchor.constraint(equalToConstant: likeButton.frame.width),
            likeButton.heightAnchor.constraint(equalToConstant: likeButton.frame.height)
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func shareTapped() {
        viewModel?.viewDelegate?.showShare()
    }
    
    @objc func likeButtonTapped() {
    }
    
    func isLikeButtonTapped() -> Bool {
        return likeButton.image != UIImage(named: "like")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        if (flowLayout?.scrollDirection == UICollectionView.ScrollDirection.horizontal) {
            return
        } else {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = isCollectionVertical ? UICollectionView.ScrollDirection.vertical : UICollectionView.ScrollDirection.horizontal
            self.collectionView.collectionViewLayout = layout
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // start ImageCollectionViewControllerDelegate
    
    func showAddedLike() {
        self.likeButton.image = UIImage(named: "like_added")
    }
    
    func showDefaultLike() {
        self.likeButton.image = UIImage(named: "like")
    }
    
    func closeView() {
        
    }
    
    // end
    
}
