
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
    
    
    
    @IBOutlet weak var plantTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userName: UILabel!
    var mapView: GMSMapView!
    @IBOutlet weak var profile_back: UIView!
    @IBOutlet weak var profile_image: RoundedImageView!
    var ref: DatabaseReference!
    var  plantsList = [Plant]()//all plantlist
    var  showTableViewPlantsList = [Plant]()//select some plantlist from plantsList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setuserProfile()
        settingFBRDB()
        setPlantsListModel()
       // showgooglemap(x:"53",y:"54")
    } 
    @IBAction func logoutButton(_ sender: Any) {
        print("button")
        logout()
    }
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
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
        return showTableViewPlantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for:indexPath) as! ProfileCellTableViewCell
        let plant : Plant
        plant = showTableViewPlantsList[indexPath.row]
        //todo user에 물주기,분갈이,장소날짜업데이트
        cell.plantName.text = plant.name
        cell.placeF.text = plant.place
        cell.waterF.text = plant.f_winter
        cell.pid.text = String(plant.pid)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileCellTableViewCell
        let pid = Int(cell.pid.text!)
        //  PVplantName.text = cell.PlantName.text
        initializeContainerView(pid: pid!)
    }
    
    func initializeContainerView(pid: Int) {
        let infoViewController = storyboard?.instantiateViewController(withIdentifier: "PlantInfoPopupViewController") as! PlantInfoPopupViewController
        infoViewController.plant.append(plantsList[pid])
        infoViewController.modalPresentationStyle = .overCurrentContext
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.size
        present(infoViewController, animated: true, completion: nil)
    }
    
    func setPlantsListModel(){
        var ref: DatabaseReference!
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        //ref.child("users").child(User.uid).child("MyPlants").child(plant[0].name).setValue(["Explanation": plant[0].Explanation,"NumericalData": plant[0].NumericalData,"name": plant[0].name])
        ref.child("users").child(User.uid).child("MyPlants").observe(DataEventType.value, with: { (snapshot) in
            
            self.plantsList.removeAll()
            var count = 0
            for plants in snapshot.children.allObjects as! [DataSnapshot]{
                let plantObject = plants.value as? [String: AnyObject]
                let NumericalData = plantObject?["NumericalData"] as? [String: AnyObject]
                let Explanation = plantObject?["Explanation"] as? [String: AnyObject]
                let name = plantObject!["name"]
                
                let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String, pid: count)
                self.plantsList.append(plants)
                count += 1
            }
            self.showTableViewPlantsList = self.plantsList
            self.plantTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}
