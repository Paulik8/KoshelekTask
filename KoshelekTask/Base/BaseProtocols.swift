//
//  BaseProtocols.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

protocol BaseCollectionViewUpdate {
    
    func startLoading()
    func updateData()
    func showError()
    func showShare()
    func stopLoading()
    func scrollToFirstItem()
}
