//
//  BaseCollectionViewController.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class BaseCollectionViewController<T:Collection>: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, BaseCollectionViewUpdate {
    
    var cellIdentifier: String = ""
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = isCollectionVertical ? UICollectionView.ScrollDirection.vertical : UICollectionView.ScrollDirection.horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = !isCollectionVertical
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = ColorsDesign.background
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    var viewModel: BaseViewModel<T>?
    var isCollectionVertical: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupCollectionView()
        registerCollectionView()
        setupUi()
        setupListeners()
        loadData()
    }
    
    func setupCollectionView() {
    }
    
    func registerCollectionView() {
        cellIdentifier = "BreedsCellIdentifier"
        collectionView.register(BreedsCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func loadData() {
        viewModel?.loadItems()
    }
    
    func initViewModel() {
    }
    
    func setupListeners() {
        viewModel?.viewDelegate = self
    }
    
    override func setupUi() {
        super.setupUi()
        view.addSubview(collectionView)
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // start UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel,
            let items = viewModel.items else { return 0 }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    // end
    
    // start BaseCollectionViewUpdate
    
    func updateData() {
        self.collectionView.reloadData()
    }
    
    func showError() {
        guard let viewModel = self.viewModel,
            let error = viewModel.error else { return }
        let alert = UIAlertController(title: "Some error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showShare() {
        let alert = UIAlertController(title: "Share photo", message: nil, preferredStyle: .actionSheet)
       alert.addAction(UIAlertAction(title: "Share", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
       self.present(alert, animated: true, completion: nil)
    }
    
    func startLoading() {
        self.loader.startAnimating()
    }
    
    func stopLoading() {
        self.loader.stopAnimating()
    }
    
    func scrollToFirstItem() {
        scrollViewDidScroll(UIScrollView())
    }
    
    // end
    
}
