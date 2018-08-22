//
//  InsertView.swift
//  atticYAdmin
//
//  Created by 김지영 on 2018. 8. 22..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit

class InsertView: UIView {
    private let xibName = "InsertView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
