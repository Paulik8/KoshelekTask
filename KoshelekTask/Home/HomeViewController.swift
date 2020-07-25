//
//  HomeView.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import UIKit

final class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbarMenu()
    }
    
    private func setupNavbarMenu() {
        tabBar.barTintColor = ColorsDesign.background
        guard let listImage = UIImage(named: "list"),
            let favouritesImage = UIImage(named: "like") else { return }
        viewControllers = [
            createTabBarItem(for: BreedsViewController(), navTitle: "Breeds", with: "List", image: listImage, tag: 0),
            createTabBarItem(for: FavouritesViewController(), navTitle: "Breeds and subbreeds", with: "Favourites", image: favouritesImage, tag: 1)
        ]
    }
    
    private func createTabBarItem(for view: UIViewController, navTitle: String, with title: String, image: UIImage, tag: Int) -> UINavigationController {
        let view = UINavigationController(rootViewController: view)
        view.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        view.navigationBar.topItem?.title = navTitle
        view.navigationBar.barTintColor = ColorsDesign.background
        view.navigationBar.setBottomBorderColor(color: .darkGray, height: 1.5)
        return view
    }
    
}

extension UINavigationBar {

    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}
