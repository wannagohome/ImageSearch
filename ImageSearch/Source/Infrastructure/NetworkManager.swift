//
//  NetworkManager.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

import Foundation
import RxSwift

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ request: URLRequest) -> Single<Data> {
        return Single.create { [weak self] single in
            let dataTask = self?.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    return
                }
                if statusCode >= 300 || statusCode < 200 {
                    single(.failure(NetworkError.http(statusCode: statusCode)))
                    return
                }
                
                
                guard let data = data else {
                    single(.failure(NetworkError.noData))
                    return
                }
                single(.success(data))
            }
            
            dataTask?.resume()
            
            return Disposables.create {
                dataTask?.cancel()
            }
        }
    }
}
