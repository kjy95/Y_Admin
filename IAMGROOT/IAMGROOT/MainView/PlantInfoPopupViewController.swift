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
    @IBOutlet weak var explanationLabel: UITextView!
    @IBOutlet weak var naviBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        changeInfoLabe()
        // Do any additional setup after loading the view.
    }
    
    func changeInfoLabe(){
        plantName.attributedText = NSAttributedString(string: plant[0].name)
        explanationLabel.attributedText = NSAttributedString(string: plant[0].explanation)
        
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
