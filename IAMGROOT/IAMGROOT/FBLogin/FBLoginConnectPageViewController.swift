//
//  FBLoginConnectPageViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 16..
//  Copyright © 2018년 김지영. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI

class FBLoginConnectPageViewController : UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    
}
