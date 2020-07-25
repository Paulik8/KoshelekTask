//
//  ImageCell.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFit
        photo.sizeToFit()
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    var url: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUi() {
        contentView.addSubview(photo)
        contentView.addSubview(loader)
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func loadImage(by link: String, onError: @escaping (Error) -> Void) {
        loader.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            self.url = link
            if let _image = CacheManager.shared.getCachedImage(id: link) {
                self.setImage(by: link, image: _image)
            } else {
                guard let url = URL(string: link) else { return }
                do {
                    let data = try Data(contentsOf: url)
                    self.setImage(by: link, data: data)
                } catch (let error) {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
            }
        }
    }
    
    private func setImage(by link: String, data: Data? = nil, image: UIImage? = nil) {
        DispatchQueue.main.async {
            if self.url == link {
                if let _image = image {
                    self.stopAnimating()
                    self.photo.image = _image
                } else {
                    guard let _data = data,
                        let convertedImage = UIImage(data: _data) else { return }
                    CacheManager.shared.cacheImage(id: link, data: convertedImage)
                    self.stopAnimating()
                    self.photo.image = convertedImage
                }
            }
        }
    }
    
    private func stopAnimating() {
        self.loader.stopAnimating()
    }
    
}
