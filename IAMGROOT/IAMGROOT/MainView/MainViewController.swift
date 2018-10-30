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
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var textfield3: UITextField!
    
    var ref: DatabaseReference!
    //Take a Google Map Object. Don't make outlet from Storyboard, Break the outlet of GMSMapView if you made an outlet
    var mapView:GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        //changeLabel_getInfoFromFBRDB()
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        //
        let withLatitude: String = textfield1.text!
        let longitude: String = textfield3.text!
        let lock: String = textfield2.text!
        
        self.ref.child("users").child(User.uid).setValue(["withLatitude": withLatitude,"longitude": longitude,"lock": lock])
        changeLabel_getInfoFromFBRDB()
        showgooglemap(x:withLatitude, y: longitude)
    }
    func changeLabel_getInfoFromFBRDB(){
        ref.child("users").child(User.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.label1.text = value!["withLatitude"] as? String
            self.label2.text = value!["longitude"] as? String
            self.label3.text = value!["lock"] as? String
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func showgooglemap(x:String, y: String){
        //google map
        //string to float
        let numberFormatter = NumberFormatter()
        let numberx = numberFormatter.number(from: x)
        let numberFloatValuex = numberx?.floatValue
        let numbery = numberFormatter.number(from: y)
        let numberFloatValuey = numbery?.floatValue

        mapView = GMSMapView.map(withFrame: CGRect(x: 39, y: 290, width: 350, height: 350), camera: GMSCameraPosition.camera(withLatitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!), zoom: 6.5))
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!))
          marker.map = mapView
        //so the mapView is of width 200, height 200 and its center is same as center of the self.view
        //mapView?.center = self.view.center
        
        self.view.addSubview(mapView!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
