//
//  SplashController.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import Combine

protocol SplashControllerHandler: Presentable {
    
}

final class SplashController: UIViewController, SplashControllerHandler {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: SplashViewModelProtocol
    private var contentView: SplashView
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: SplashViewModelProtocol, view: SplashView) {
        self.contentView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelDataStreamsToView()
        bindViewInteractionsDownstreamToViewModel()
    }
}

extension SplashController {
    private func bindViewModelDataStreamsToView() {
        
    }
    
    private func bindViewInteractionsDownstreamToViewModel() {
        
    }
}
