//
//  SettingViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 27/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    @IBOutlet weak var settingPermitFriendRecommendButton: UISwitch!
    var FriendRecommendSetting: Bool!
    var ref: DatabaseReference!
    var refUser: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingButton()
    }
    func setSettingButton(){
        //todo
    }
    @IBAction func naviBar_back(_ sender: Any) {
        self.dismiss(animated: User.FriendRecommendSetting, completion: nil)
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
        settingFBRDB()
        updateSettingFriendData()
    }
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
        refUser = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
    }
    func updateSettingFriendData(){
        User.FriendRecommendSetting = settingPermitFriendRecommendButton.isOn
        refUser.child("users/\(User.uid!)/Setting/FriendRecommend").setValue(User.FriendRecommendSetting)
    }
}
