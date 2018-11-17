//
//  MainViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 21..
//  Copyright © 2018년 김지영. All rights reserved.
//


import UIKit
import Firebase
import GoogleMaps
import FSCalendar

class MainViewController : UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    var scrollDirection: FSCalendarScrollDirection = .vertical
    var ref: DatabaseReference!
    //Take a Google Map Object. Don't make outlet from Storyboard, Break the outlet of GMSMapView if you made an outlet
    var mapView:GMSMapView?
    @IBOutlet weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        setCalendar()
        
        
    }
    func setCalendar(){
        calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택할 수 있도록
        //calendar.clipsToBounds = true //달력 구분 선 제거
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.eventDefaultColor = UIColor.green
        //self.calendar.select(Date())
         self.calendar.scope = .month
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"

    }
    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    func calendar(calendar: FSCalendar, subtitleForDate date: NSDate) -> String? {
        return "W"
    }
    
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        print(date)
    }
    
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        /*let withLatitude: String = textfield1.text!
        let longitude: String = textfield3.text!
        let lock: String = textfield2.text!
        
        self.ref.child("users").child(User.uid).setValue(["withLatitude": withLatitude,"longitude": longitude,"lock": lock])
        changeLabel_getInfoFromFBRDB()
        showgooglemap(x:withLatitude, y: longitude)*/
    }
    func changeLabel_getInfoFromFBRDB(){
        /*ref.child("users").child(User.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.label1.text = value!["withLatitude"] as? String
            self.label2.text = value!["longitude"] as? String
            self.label3.text = value!["lock"] as? String
        }) { (error) in
            print(error.localizedDescription)
        }*/
    }
    func showgooglemap(x:String, y: String){
        //google map
        //string to float
        let numberFormatter = NumberFormatter()
        let numberx = numberFormatter.number(from: x)
        let numberFloatValuex = numberx?.floatValue
        let numbery = numberFormatter.number(from: y)
        let numberFloatValuey = numbery?.floatValue

        mapView = GMSMapView.map(withFrame: CGRect(x: 39, y: 290, width: 350, height: 350), camera: GMSCameraPosition.camera(withLatitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!), zoom: 6.5))
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(numberFloatValuex!), longitude: CLLocationDegrees(numberFloatValuey!))
          marker.map = mapView
        //so the mapView is of width 200, height 200 and its center is same as center of the self.view
        //mapView?.center = self.view.center
        
        self.view.addSubview(mapView!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
