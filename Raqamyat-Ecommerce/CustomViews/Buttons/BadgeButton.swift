//
//  BadgeButton.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 11/12/2022.
//

import UIKit

class BadgeButton: UIButton {
    
    let badgeView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let badgeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    var badgeBackGroundColor: UIColor?  {
        didSet {
            badgeView.backgroundColor = badgeBackGroundColor
        }
    }
    
}
