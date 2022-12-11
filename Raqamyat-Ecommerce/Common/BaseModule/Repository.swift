//
//  BaseRepository.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 10/12/2022.
//

import Foundation
import Combine

enum RepositoryState {
    case idle
    case loading
    case error(_ error: Error)
}

protocol AnyRepository: NSObject {
    var repositoryStatePublisher: AnyPublisher<RepositoryState, Never> { get }
    
}

class Repository: NSObject, AnyRepository {
    
    @Published var repositoryState: RepositoryState = .idle
    var repositoryStatePublisher: AnyPublisher<RepositoryState, Never> {
        return $repositoryState.eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
    }
}
