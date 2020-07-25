//
//  BreedService.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

final class BreedService: NetworkService {
    
    var baseUrl: String = "https://dog.ceo/api/"
    
    func loadBreedsList(onSuccess: @escaping (BreedsArray) -> Void, onError: @escaping (Error) -> Void) {
        let path = "breeds/list/all"
        guard let url = URL(string: self.baseUrl + path) else { return }
        loadAsyncData(by: url, with: BreedsResponse.self, onSuccess: { data in
            let arr = Array(data.message).sorted { $0.0 < $1.0 }
            DispatchQueue.main.async {
                onSuccess(arr)
            }
        }, onError: { error in
            DispatchQueue.main.async {
                onError(error)
            }
        })
    }
    
    func loadImagesByBreed(by breed: String, subbreed: String?, onSuccess: @escaping (BreedImages) ->  Void, onError: @escaping (Error) -> Void) {
        var path: String
        if let subbreedData = subbreed {
            path = "breed/\(breed)/\(subbreedData)/images"
        } else {
            path = "breed/\(breed)/images"
        }
        guard let url = URL(string: self.baseUrl + path) else { return }
        loadAsyncData(by: url, with: ImageResponse.self, onSuccess: { data in
                onSuccess(data.message)
        }, onError: { error in
            DispatchQueue.main.async {
                onError(error)
            }
        })
    }
    
}
