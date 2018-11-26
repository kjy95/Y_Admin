//
//  RoundedButton.swift
//  IAMGROOT
//
//  Created by 김지영 on 27/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 
    override func draw(_ rect: CGRect) {
    }*/
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        
    }
}
