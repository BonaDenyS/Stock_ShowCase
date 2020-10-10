//
//  RoundButton.swift
//  Decideat
//
//  Created by Bona Deny S on 20/02/19.
//  Copyright © 2019 Decideat.Inc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        layer.masksToBounds =  false
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
}
