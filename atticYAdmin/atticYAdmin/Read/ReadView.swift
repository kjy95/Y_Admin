//
//  ReadView.swift
//  atticYAdmin
//
//  Created by 김지영 on 2018. 8. 22..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ReadView: UIView {
    
    private let xibName = "ReadView"
    var ref: DatabaseReference!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        
        ref = Database.database().reference()
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
