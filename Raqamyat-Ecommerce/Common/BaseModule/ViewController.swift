//
//  ViewController.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import UIKit
import Combine

protocol AnyViewController: Presentable {
    
}

class ViewController: UIViewController {

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: AnyViewModel
    private var subscriptions = Set<AnyCancellable>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: AnyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModelStatePublisherDownstream()
    }
    
    func showLoader() {
        view.displayAnimatedActivityIndicatorView()
    }
    
    func hideLoader() {
        view.hideAnimatedActivityIndicatorView()
    }
    
    private func bindToViewModelStatePublisherDownstream() {
        viewModel.viewModelStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] state in
                switch state {
                case .onLoading:
                    self.showLoader()
                case .onFinishedLoading:
                    self.hideLoader()
                case .onError:
                    break
                }
            }.store(in: &subscriptions)
    }
}
