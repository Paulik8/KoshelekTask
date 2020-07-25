//
//  BreedsViewModel.swift
//  KoshelekTask
//
//  Created by Paulik on 21.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class BreedsViewModel: BaseViewModel<BreedsArray>, BreedsViewModelProtocol {
    
    let breedsRepository: BreedsRepository = BreedsRepository.shared
    let breedService = BreedService()
    
    func loadData() {
        viewDelegate?.startLoading()
        breedService.loadBreedsList(
            onSuccess: {
                self.viewDelegate?.stopLoading()
                self.items = $0
        },
            onError: {
                self.viewDelegate?.stopLoading()
                self.error = $0
        })
    }
    
}
