
//
//  MainPrivateViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 09/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

import GoogleMaps
import Firebase
class MainPrivateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userName: UILabel!
    var mapView: GMSMapView!
    @IBOutlet weak var profile_back: UIView!
    @IBOutlet weak var profile_image: RoundedImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setuserProfile()
        showgooglemap(x:"53",y:"54")
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
    func setuserProfile(){
        self.userName.text = User.name
    }
    func showgooglemap(x:String, y: String){
        //google map
        //string to float
        let numberFormatter = NumberFormatter()
        let numberx = numberFormatter.number(from: x)
        let numberFloatValuex = numberx?.floatValue
        let numbery = numberFormatter.number(from: y)
        let numberFloatValuey = numbery?.floatValue
        
        mapView = GMSMapView.map(withFrame: CGRect(x: backgroundView.frame.minX+20, y: backgroundView.frame.minY+22, width: backgroundView.frame.width, height: backgroundView.frame.height), camera: GMSCameraPosition.camera(withLatitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!), zoom: 6.5))
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!))
        marker.map = mapView
        //so the mapView is of width 200, height 200 and its center is same as center of the self.view
        //mapView?.center = self.view.center
        self.view.addSubview(mapView!)
        self.view.sendSubviewToBack(mapView)
        self.view.sendSubviewToBack(profile_back)
        self.view.sendSubviewToBack(backgroundView)
    }
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as UITableViewCell!
        return cell!
    }
    
    
}
