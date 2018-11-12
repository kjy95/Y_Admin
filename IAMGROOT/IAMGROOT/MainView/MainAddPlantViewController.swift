//
//  MainAddPlantViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 11/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit
import Firebase

class MainAddPlantViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var ref: DatabaseReference!
    //var
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingFBRDB()
        getPlantsInfo()
    }
    
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
    }
    func getPlantsInfo(){
        ref.child("/EP8HR2gkeGSH2RAQpEGbVglVh0J3").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //self.label1.text = value!["withLatitude"] as? String
            print(value!["name"] as? String)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBRDBplantsCell") as UITableViewCell!
        return cell!
    }
    
}
