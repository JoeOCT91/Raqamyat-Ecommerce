//
//  BaseViewModel.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 10/12/2022.
//

import Foundation
import Combine

enum ViewModelState {
    case onLoading
    case onFinishedLoading
    case onError
}

protocol AnyViewModel: NSObject {
    var viewModelStatePublisher: AnyPublisher<ViewModelState, Never> { get }
}

class ViewModel: NSObject, AnyViewModel {
    
    @Published private var viewModelState: ViewModelState?
    var viewModelStatePublisher: AnyPublisher<ViewModelState, Never> {
        return $viewModelState
            .compactMap({$0})
            .eraseToAnyPublisher()
    }
    
    var subscriptions = Set<AnyCancellable>()
    private var repository: AnyRepository
    
    init(repository: AnyRepository) {
        self.repository = repository
        super.init()
        bindToRepositoryStatePublisherDownStream()
    }
    
    private func bindToRepositoryStatePublisherDownStream() {
        repository.repositoryStatePublisher
            .sink { [unowned self] state in
                switch state {
                case .idle:
                    self.viewModelState = .onFinishedLoading
                case .loading:
                    self.viewModelState = .onLoading
                case .error(_):
                    break
                }
            }.store(in: &subscriptions)
    }
    
    deinit {
        let content = self.description + " Has been deinitialized "
        let dashed = String(repeating: "#", count: content.count)
        print(dashed)
        print(content)
        print(dashed)
    }
}
