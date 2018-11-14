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
    @IBOutlet weak var plantsTableView: UITableView!
    var ref: DatabaseReference!
    @IBOutlet weak var searchTextfield: UITextField!
    var  plantsList = [Plant]()
    override func viewDidLoad() {
        super.viewDidLoad()
        plantsTableView.dataSource = self
        plantsTableView.delegate = self
        self.settingFBRDB()
        plantsList = [Plant]()
        setPlantsListModel()
    }
    
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
    }
   
    @IBAction func SearchButton(_ sender: Any) {
        let plantName = searchTextfield.text!
        if !plantName.isEmpty{
            
            plantsList = [Plant]()
            
            ref.child("EP8HR2gkeGSH2RAQpEGbVglVh0J3").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                //let value = snapshot.value as? NSDictionary
                
                self.plantsList.removeAll()
                for plants in snapshot.children.allObjects as! [DataSnapshot]{
                    let plantObject = plants.value as? [String: AnyObject]
                    let NumericalData = plantObject?["NumericalData"] as? [String: AnyObject]
                    let Explanation = plantObject?["Explanation"] as? [String: AnyObject]
                    let name = plantObject!["name"]
                    
                    let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String)
                     self.plantsList.append(plants)
                    print("plantlist")
                    print(plants.Explanation)
                    print(plants.NumericalData)
                    print(plants.name)
                    
                }
                // self.label3.text = value!["lock"] as? String
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        self.plantsTableView.reloadData()
    }
    func setPlantsListModel(){
        plantsList = [Plant]()
        ref.child("EP8HR2gkeGSH2RAQpEGbVglVh0J3").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //let value = snapshot.value as? NSDictionary
            
            self.plantsList.removeAll()
            for plants in snapshot.children.allObjects as! [DataSnapshot]{
                let plantObject = plants.value as? [String: AnyObject]
                let NumericalData = plantObject?["NumericalData"] as? [String: AnyObject]
                let Explanation = plantObject?["Explanation"] as? [String: AnyObject]
                let name = plantObject!["name"]
                
                let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String)
                self.plantsList.append(plants)
                print("plantlist")
                print(plants.Explanation)
                print(plants.NumericalData)
                print(plants.name)
                print(self.plantsList.count)
            }
            // self.label3.text = value!["lock"] as? String
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.plantsTableView.reloadData()
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
        print("왜안나와2")
        return plantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("왜안나와")
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPlantsTableViewCell", for:indexPath) as! SearchPlantsTableViewCell
        let plant : Plant
        plant = plantsList[indexPath.row]
        cell.PlantName.text = plant.name
        cell.explanation.text = plant.explanation
        
        return cell
    }
    
}
