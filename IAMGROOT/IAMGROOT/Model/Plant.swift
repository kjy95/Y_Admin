//
//  Plants.swift
//  IAMGROOT
//
//  Created by 김지영 on 13/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class Plant{
    var pid : Int
    var Explanation:[String:AnyObject]
    var Flowerpot: String
    var explanation: String
    var frequency: String
    var place: String
    
    var NumericalData:[String:AnyObject]
    var f_fall: String
    var f_spring: String
    var f_summer: String
    var f_winter: String
    var flowerpot: String
    var p_fall: String
    var p_spring: String
    var p_summer: String
    var p_winter: String
    
    var name: String
    
    var PrivateFrequency:[String:AnyObject]!
    var private_f_fall : String!
    var private_f_spring : String!
    var private_f_summer : String!
    var private_f_winter : String!
    var private_flowerpot : String!
    var private_p_fall : String!
    var private_p_spring : String!
    var private_p_summer : String!
    var private_p_winter : String!
    var private_waterDate = [Date]()
    
    init(Explanation: [String:AnyObject],NumericalData: [String:AnyObject], name: String, pid: Int){
        self.pid = pid
        self.Explanation = Explanation
        self.Flowerpot = Explanation["Flowerpot"] as! String
        self.explanation = Explanation["explanation"] as! String
        self.place = Explanation["place"] as! String
        self.frequency = Explanation["frequency"] as! String
        
        self.NumericalData = NumericalData
        self.f_fall = NumericalData["f_fall"] as! String
        self.f_spring = NumericalData["f_spring"] as! String
        self.f_summer = NumericalData["f_summer"] as! String
        self.f_winter = NumericalData["f_winter"] as! String
        self.flowerpot = NumericalData["flowerpot"] as! String
        self.p_fall = NumericalData["p_fall"] as! String
        self.p_spring = NumericalData["p_spring"] as! String
        self.p_summer = NumericalData["p_summer"] as! String
        self.p_winter = NumericalData["p_winter"] as! String
        
        self.name = name;
        
    }
}
