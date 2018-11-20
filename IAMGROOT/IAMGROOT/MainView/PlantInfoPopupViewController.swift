//
//  PlantInfoPopupViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 16/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit
import Firebase
class PlantInfoPopupViewController: UIViewController {
    var  plant = [Plant]()
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var ExpLable: UILabel!
    @IBOutlet weak var fstInfoView: UIView!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var addPlantButton: UIButton!
    @IBOutlet weak var NumericalDataFlowerpotLabel: UILabel!
    @IBOutlet weak var FlowerpotLabel: UILabel!
    @IBOutlet weak var NumFLabel: UILabel!
    @IBOutlet weak var NumF2Label: UILabel!
    @IBOutlet weak var frequenceyLabel: UILabel!
    @IBOutlet weak var NumPLabel: UILabel!
    @IBOutlet weak var NumP2Label: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeInfoLabe()
        viewborder()
        // Do any additional setup after loading the view.
    }
    
    func changeInfoLabe(){
        plantName.attributedText = NSAttributedString(string: plant[0].name)
        ExpLable.attributedText = NSAttributedString(string: plant[0].explanation)
        ExpLable.sizeToFit()
        NumericalDataFlowerpotLabel.attributedText = NSAttributedString(string: "1년에 \(plant[0].flowerpot)번" )
        FlowerpotLabel.attributedText = NSAttributedString(string:plant[0].Flowerpot )
        NumFLabel.attributedText = NSAttributedString(string: "봄: 1개월에 \(plant[0].f_spring)번 물을 주세요.\n가을: 1개월에 \(plant[0].f_spring)번 물을 주세요." )
        NumF2Label.attributedText = NSAttributedString(string: "여름: 1개월에 \(plant[0].f_summer)번 물을 주세요.\n겨울: 1개월에 \(plant[0].f_winter)번 물을 주세요." )
        frequenceyLabel.attributedText = NSAttributedString(string: plant[0].frequency )
        NumPLabel.attributedText = NSAttributedString(string: "봄: \(plant[0].p_spring)\n가을: \(plant[0].p_spring)" )
        NumP2Label.attributedText = NSAttributedString(string: "여름: \(plant[0].p_summer)\n겨울: \(plant[0].p_winter)" )
        placeLabel.attributedText = NSAttributedString(string:plant[0].place )
    }
    @IBAction func addPlant(_ sender: Any) {
        //todo nsdefault로 앱에 남겨둔다
        let alert=UIAlertController(title:"식물 추가", message: "내 식물에 추가하실 건가요?", preferredStyle:UIAlertController.Style.alert )
        
        alert.addAction(UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {
            _ in self.userPlantUpdate()
        }))
        alert.addAction(UIAlertAction(title: "아니요", style: UIAlertAction.Style.cancel, handler: {
            _ in
        }))
        present(alert, animated: true, completion: nil)

    }
    func userPlantUpdate(){
        var ref: DatabaseReference!
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
           ref.child("users").child(User.uid).child("MyPlants").child(plant[0].name).setValue(["Explanation": plant[0].Explanation,"NumericalData": plant[0].NumericalData,"name": plant[0].name, "PrivateFrequency": plant[0].NumericalData])
    }
    /*func setPrivateFreauency(){
        let currentSeason = getCurrentSeason()
        if (currentSeason == "spring"){
            plant[0].PrivateFrequency["private_f_spring"] = ""
        } 
    }*/
    
    func viewborder(){
        fstInfoView.layer.borderColor = UIColor.gray.cgColor
        fstInfoView.layer.borderWidth = 1.0
        //todo 선이 사진 위에 보이는거 해결해야된다
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
    @IBAction func naviBar_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}


