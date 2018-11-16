//
//  PlantInfoPopupViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 16/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class PlantInfoPopupViewController: UIViewController {
var info = " asd"
    override func viewDidLoad() {
        super.viewDidLoad()
        plantName.attributedText = NSAttributedString(string: info)
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var naviBar: UINavigationBar!
    
    @IBAction func naviBar_back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var plantName: UILabel!
    func change(p: String){
        plantName.attributedText = NSAttributedString(string: info)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
