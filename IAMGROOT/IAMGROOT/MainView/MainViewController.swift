//
//  MainViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 21..
//  Copyright © 2018년 김지영. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseUI

class MainViewController : UIViewController {
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var label1: UILabel!
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        getInfoFromFBRDB()
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        //
        let location: String = textfield1.text!
        
        self.ref.child("users").child(User.uid).setValue(["location": location])
        getInfoFromFBRDB()
    }
    func getInfoFromFBRDB(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(User.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            self.label1.text = value!["location"] as? String
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
