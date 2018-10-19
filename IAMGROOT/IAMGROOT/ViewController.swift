//
//  ViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 15..
//  Copyright © 2018년 김지영. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad() 
        let gameScene = UIStoryboard(name: "FBLoginConnectPageViewController", bundle:nil).instantiateViewController(withIdentifier: "FBLoginConnectPageViewController") as UIViewController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = gameScene
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
