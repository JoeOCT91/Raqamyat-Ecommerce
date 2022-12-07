//
//  ProductDetailsController.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 08/12/2022.
//

import UIKit
import Combine

protocol ProductDetailsControllerProtocol: Presentable {
    
}

final class ProductDetailsController: UIViewController, ProductDetailsControllerProtocol {

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Coordinator helpers ...
    //----------------------------------------------------------------------------------------------------------------
    var onProductTapPublisher = PassthroughSubject<Void, Never>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: ProductDetailsViewModelProtocol
    private var contentView: ProductDetailsView
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: ProductDetailsViewModelProtocol, view: ProductDetailsView) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ProductDetailsController {
    private func bindViewModelDataStreamsToView() {
        
    }
    
    private func bindViewInteractionsDownstreamToViewModel() {
        
    }
}
