//
//  User.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 23..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit

class User {
    var uid: String = ""
    var name: String = ""
    var age: String = ""
    var email: String = ""
    var id: String = ""
    var pw: String = ""
    //최대 20개~식물을 자신의 식물로 저장가능. 딕셔너리 리스트. 고유번호(인덱스 넣기)
    var myPlants = [[]]
    var myPlantEvaluation = [String]()
}
