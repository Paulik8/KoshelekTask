//
//  NetworkService.swift
//  KoshelekTask
//
//  Created by Paulik on 23.07.2020.
//  Copyright © 2020 Paulik. All rights reserved.
//

import Foundation

class NetworkService {
    
    func loadAsyncData<T:Decodable>(by url: URL, with type: T.Type, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedData)
            } catch (let error) {
                onError(error)
            }
        }
    }
    
}
