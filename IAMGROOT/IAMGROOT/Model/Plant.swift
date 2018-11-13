//
//  Plants.swift
//  IAMGROOT
//
//  Created by 김지영 on 13/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class Plant{//Store Data Globally
    var key: String
    
    var Explanation:[String:String]
    var Flowerpot: String
   /* var explanation: String
    var frequency: String
    var place: String
    
    var NumericalData:[String:String]
    var f_fall: String
    var f_spring: String
    var f_summer: String
    var f_winter: String
    var flowerpot: String
    var p_fall: String
    var p_spring: String
    var p_summer: String
    var p_winter: String
 
    var name: String*/
    init(dictionary: [String: [String:String]], key: String){
        self.key = key
        self.Explanation = dictionary["Explanation"]!
        self.Flowerpot = self.Explanation["Flowerpot"] as! String
        
    }
}
