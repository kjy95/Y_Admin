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
import GoogleMaps

class MainViewController : UIViewController {
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var label1: UILabel!
    
    var ref: DatabaseReference!
    //Take a Google Map Object. Don't make outlet from Storyboard, Break the outlet of GMSMapView if you made an outlet
    var mapView:GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        getInfoFromFBRDB()
        //google map
        mapView = GMSMapView.map(withFrame: CGRect(x: 59, y: 280, width: 350, height: 350), camera: GMSCameraPosition.camera(withLatitude: 51.050657, longitude: 10.649514, zoom: 5.5))
        
        //so the mapView is of width 200, height 200 and its center is same as center of the self.view
        //mapView?.center = self.view.center
        
        self.view.addSubview(mapView!)
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
