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
    var  plantsList = [Plant]()//all plantlist
    var  showTableViewPlantsList = [Plant]()//select some plantlist from plantsList
    override func viewDidLoad() {
        super.viewDidLoad()
        plantsTableView.dataSource = self
        plantsTableView.delegate = self
        settingFBRDB()
        setPlantsListModel()
        
    }
    
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
    }
   
    @IBAction func SearchButton(_ sender: Any) {
        
        let plantName = searchTextfield.text!
        if !plantName.isEmpty{
            self.showTableViewPlantsList.removeAll()
            for plants in plantsList{
                let NumericalData = plants.NumericalData
                let Explanation = plants.Explanation
                let name = plants.name
                if(name == plantName){
                    let plant = Plant(Explanation: Explanation,NumericalData:  NumericalData, name: name )
                    self.showTableViewPlantsList.append(plant)
                }
                print("plantlist")
                print(plants.Explanation)
                print(plants.NumericalData)
                print(plants.name)
                
            }
            self.plantsTableView.reloadData()
        }
    }
    func setPlantsListModel(){
        ref.child("EP8HR2gkeGSH2RAQpEGbVglVh0J3").observe(DataEventType.value, with: { (snapshot) in
            
            self.plantsList.removeAll()
            for plants in snapshot.children.allObjects as! [DataSnapshot]{
                let plantObject = plants.value as? [String: AnyObject]
                let NumericalData = plantObject?["NumericalData"] as? [String: AnyObject]
                let Explanation = plantObject?["Explanation"] as? [String: AnyObject]
                let name = plantObject!["name"]
                
                let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String)
                self.plantsList.append(plants)
            }
            self.showTableViewPlantsList = self.plantsList
            self.plantsTableView.reloadData()
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
        return showTableViewPlantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchPlantsTableViewCell", for:indexPath) as! SearchPlantsTableViewCell
        let plant : Plant
        plant = showTableViewPlantsList[indexPath.row]
        cell.PlantName.text = plant.name
        cell.explanation.text = plant.explanation
        
        return cell
    }
    
}
