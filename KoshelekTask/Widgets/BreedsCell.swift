//
//  BreedsCell.swift
//  KoshelekTask
//
//  Created by Paulik on 22.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

class BreedsCell: UICollectionViewCell {
    
    var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 18)
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var subBreeds: UILabel = {
        let sub = UILabel()
        sub.font = UIFont.systemFont(ofSize: 14)
        sub.textColor = .black
        sub.translatesAutoresizingMaskIntoConstraints = false
        return sub
    }()
    
    var arrow: UIImageView = {
        let image = UIImageView(image: UIImage(named: "arrow"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUi() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 0.7
        addSubview(name)
        addSubview(subBreeds)
        addSubview(arrow)
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            subBreeds.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 8),
            subBreeds.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.name.text = nil
        self.subBreeds.text = nil
    }
    
    func updateValues(name: String, items: Int? = nil, favourites: Bool = false) {
        self.name.text = name
        if (favourites) {
            guard let wrappedItems = items else { return }
            self.subBreeds.text = "(\(wrappedItems) photos)"
        } else {
            guard let wrappedItems = items else { return }
            self.subBreeds.text = "(\(wrappedItems) subbreeds)"
        }
    }
}
