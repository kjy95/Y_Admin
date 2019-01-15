//
//  User.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 23..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit

class User : NSObject{//Store Data Globally
    static var uid: String! 
    static var name: String!
    static var age: String!
    static var email: String!
    static var phoneNum: String!
    static var accessibilityLanguage: String! 
    //최대 20개~식물을 자신의 식물로 저장가능. 딕셔너리 리스트. 고유번호(인덱스 넣기)
    static var myPlants = [[]]
    static var myPlantEvaluation = [String]()
    //setting
    static var FriendRecommendSetting: Bool!
    
    
    
}
