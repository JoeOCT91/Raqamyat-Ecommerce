//
//  Home.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import Combine

protocol HomeControllerProtocol: Presentable {
    
}

final class HomeController: UIViewController, HomeControllerProtocol {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: HomeViewModelProtocol
    private var contentView: HomeView
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: HomeViewModelProtocol, view: HomeView) {
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

extension HomeController {
    private func bindViewModelDataStreamsToView() {
        
    }
    
    private func bindViewInteractionsDownstreamToViewModel() {
        
    }
}
