//
//  SettingViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 27/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingPermitFriendRecommendButton: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func naviBar_back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func switchRecommend(_ sender: Any) {
        sendFBFriendRecommendSetting()
    }
    
    
    func getSettingPermitFriendRecommendButtonState()->Bool{
        return settingPermitFriendRecommendButton.isOn
    }
    func sendFBFriendRecommendSetting(){
        //todo
        
    }
}
