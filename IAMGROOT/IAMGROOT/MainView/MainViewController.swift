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

class MainViewController : UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource{
    var scrollDirection: FSCalendarScrollDirection = .vertical
    var ref: DatabaseReference!
    var refUser: DatabaseReference!
    var  plantsList = [Plant]()//all plantlist
    var  getplantListFromAddPlantInfoVC = [Plant]()//
    @IBOutlet weak var plantsTableView: UITableView!
    var  showTableViewPlantsList = [Plant]()//select some plantlist from plantsList
    
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
        plantsTableView.dataSource = self
        plantsTableView.delegate = self
        settingFBRDB()
        setPlantsListModel()
        setCalendar()
    }
    func settingFBRDB(){
        // Get a secondary database instance by URL
        ref = Database.database(url: "https://atticyadmin.firebaseio.com/").reference()
        refUser = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        
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
        print(getplantListFromAddPlantInfoVC[0].name)
        
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
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showTableViewPlantsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for:indexPath) as! ProfileCellTableViewCell
        let plant : Plant
        plant = showTableViewPlantsList[indexPath.row]
        //todo user에 물주기,분갈이,장소날짜업데이트
        cell.plantName.text = plant.name
        cell.potF.text = plant.Flowerpot
        cell.waterF.text = plant.f_winter
        cell.pid.text = String(plant.pid)
        //버튼에 인덱스 보냄
        cell.detailButton.tag = indexPath.row
        cell.detailButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ProfileCellTableViewCell
        let pid = Int(cell.pid.text!)
        //  PVplantName.text = cell.PlantName.text
        
        initializeContainerView(pid: pid!)
    }
    func selectWaterDate()->Date{
        // 물을 준 날 plant.private["water_endDate"] = 
        
        
        return Date()
    }
    func initializeContainerView(pid: Int) {
        let infoViewController = storyboard?.instantiateViewController(withIdentifier: "PlantInfoPopupViewController") as! PlantInfoPopupViewController
        infoViewController.plant.append(plantsList[pid])
        infoViewController.modalPresentationStyle = .overCurrentContext
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.size
        present(infoViewController, animated: true, completion: nil)
    }
    @IBAction func showDetail(_ sender: Any) {
        let pid = (sender as AnyObject).tag!
        initializeContainerView(pid: pid)
    }
    
    
    func getCurrentSeason()->String{
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        if (month==3 || month==4 || month==5){
            return "spring"
        }else if(month==6 || month==7 || month==8){
            return "summer"
        }else if(month==9 || month==10 || month==11){
            return "fall"
        }else if(month==12 || month==1 || month==2){
            return "winter"
        }else{
            return "error"
        }
    }
    func setPlantsListModel(){
        //ref.child("users").child(User.uid).child("MyPlants").child(plant[0].name).setValue(["Explanation": plant[0].Explanation,"NumericalData": plant[0].NumericalData,"name": plant[0].name])
        self.refUser.child("users").child(User.uid).child("MyPlants").observe(DataEventType.value, with: { (snapshot) in
            
            self.plantsList.removeAll()
            var count = 0
            for plants in snapshot.children.allObjects as! [DataSnapshot]{
                let plantObject = plants.value as? [String: AnyObject]
                let NumericalData = plantObject?["NumericalData"] as? [String: AnyObject]
                let Explanation = plantObject?["Explanation"] as? [String: AnyObject]
                let name = plantObject!["name"]
                
                let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String, pid: count)
                self.plantsList.append(plants)
                count += 1
            }
            self.showTableViewPlantsList = self.plantsList
            self.plantsTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
