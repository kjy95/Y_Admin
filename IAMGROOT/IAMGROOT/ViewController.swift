//
//  ViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 15..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        presentMainViewController()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func presentMainViewController() {
        let mainVC = ViewController(nibName:"FBLoginConnectPageViewController", bundle:nil)
        self.navigationController?.pushViewController(mainVC, animated: true);
        // you could present it another way, such as:
        // self.presentViewController(mainVC, true, nil)
        // to present it as a modal
    }


}
