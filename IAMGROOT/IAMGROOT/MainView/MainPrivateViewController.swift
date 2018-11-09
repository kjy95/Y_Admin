
//
//  MainPrivateViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 09/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

import Firebase
class MainPrivateViewController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    } 
    @IBAction func logoutButton(_ sender: Any) {
        print("button")
        logout()
    }
    func logout(){
         let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginScene = UIStoryboard(name: "FBLoginConnectPageViewController", bundle:nil).instantiateViewController(withIdentifier: "FBLoginConnectPageViewController") as UIViewController
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.window?.rootViewController = loginScene
            print("nice serve logoout")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
