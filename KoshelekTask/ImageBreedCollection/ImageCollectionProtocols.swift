//
//  ImageCollectionProtocols.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

protocol ImageViewModelProtocol: class {
    
    var vc: ImageCollectionViewControllerDelegate? { get set }
    func setData(breed: String, subbreed: String?)
    func likeButtonTapped(by link: String, with stateTapped: Bool)
    func setupListener()
    func updateCurrentImageLink(_ link: String)
    
}

protocol ImageCollectionViewControllerDelegate: class {
    func showAddedLike()
    func showDefaultLike()
    func closeView()
}
