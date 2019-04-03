//
//  TodayViewController.swift
//  IAMGROOTExtension
//
//  Created by 김지영 on 01/04/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var wouldWaterDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          if let userDefaults = UserDefaults(suiteName: "group.com.kjy.IAMGROOT"){
            let userDefaultWouldWaterDatePlantList = userDefaults.stringArray(forKey: "userDefaultWouldWaterDatePlantList") ?? [String]()
            let userDefaultWouldWaterDatePlantNameList = userDefaults.stringArray(forKey: "userDefaultWouldWaterDatePlantNameList") ?? [String]()
             wouldWaterDate.text = userDefaultWouldWaterDatePlantList[0]
        }
        //wouldWaterDate.text = userDefaultWouldWaterDatePlantNameList[0]
        // Do any additional setup after loading the view from its nib.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
