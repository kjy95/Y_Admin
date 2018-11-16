//
//  PlantInfoPopupViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 16/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class PlantInfoPopupViewController: UIViewController {
    var  plant = [Plant]()
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var ExpLable: UILabel!
    @IBOutlet weak var fstInfoView: UIView!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var addPlantButton: UIButton!
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
        
        
    }
    @IBAction func addPlant(_ sender: Any) {
        
    }
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


