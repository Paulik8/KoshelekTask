//
//  BaseViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class BaseViewModel<T:Collection> {
    
    var items: T? {
        didSet {
            self.viewDelegate?.updateData()
        }
    }
    
    var error: Error? {
        didSet {
            DispatchQueue.main.async {
                self.viewDelegate?.showError()
            }
        }
    }
    
    var viewDelegate: BaseCollectionViewUpdate?
    
    func loadItems() {
    }
    
}

