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
    var  getplantListFromAddPlantInfoVC = [Plant]()//기르기 후 캘린더로 이동할 때 리스트받음
    var  CurrentPlantList = [Plant]()//현재 사용자가 선택한 플렌트리스트
    var  checkIsLoadedTV = false
    @IBOutlet weak var plantsTableView: UITableView!
    var  showTableViewPlantsList = [Plant]()//select some plantlist from plantsList
    
    @IBOutlet weak var SPNLabel: UILabel!
    //Take a Google Map Object. Don't make outlet from Storyboard, Break the outlet of GMSMapView if you made an outlet
    var mapView:GMSMapView?
    @IBOutlet weak var calendar: FSCalendar!
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        //이전에 것들이 다지워짐
        
        //self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        super.viewDidLoad()
        // Get a secondary database instance by URL
        plantsTableView.dataSource = self
        plantsTableView.delegate = self
        checkIsLoadedTV = false
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
        setFBData_WaterDate(dateList: selectedDates)
        
        if (CurrentPlantList.count == 1){
            print(CurrentPlantList[0].name)
                print(date)
                print(self.dateFormatter.string(from: date))
            }
        
        
    }
    
    func changeLabelName(){
        SPNLabel.text = CurrentPlantList[0].name
    }
    func selectCalendarDate(){
        let testArray = CurrentPlantList[0].private_waterDate
        var convertedArray: [Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"// dd MM, yyyy"
        for dat in testArray {
            let date = dateFormatter.date(from: dat)
            if let date = date {
                convertedArray.append(date)
            }
        }
        for temp in convertedArray{
            self.calendar.select(temp)
            
        }
    }
    func deselectCalendarDate(){
        let testArray = CurrentPlantList[0].private_waterDate
        var convertedArray: [Date] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"// dd MM, yyyy"
        for dat in testArray {
            let date = dateFormatter.date(from: dat)
            if let date = date {
                convertedArray.append(date)
            }
        }
        for temp in convertedArray{
            self.calendar.deselect(temp)
        }
    }
    func setFBData_WaterDate(dateList: [String]){
         if (CurrentPlantList.count == 1){
            var i = 0
            
            CurrentPlantList[0].private_waterDate = dateList
            refUser.child("users").child(User.uid).child("MyPlants").child(CurrentPlantList[0].name).setValue(["Explanation": CurrentPlantList[0].Explanation,"NumericalData": CurrentPlantList[0].NumericalData,"name": CurrentPlantList[0].name,"PrivateFrequency": CurrentPlantList[0].NumericalData, "private_waterDate":  CurrentPlantList[0].private_waterDate])
            /*let key = refUser.child("users").child(User.uid).child("MyPlants").child(CurrentPlantList[0].name).child("PrivateFrequency").childByAutoId().key
            let post = ["private_waterDate": CurrentPlantList[0].private_waterDate]
            let childUpdates = [key: post]
            ref.updateChildValues(childUpdates)*/
        }
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
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && checkIsLoadedTV == false {
                 if (getplantListFromAddPlantInfoVC.count == 1){
                   //delete all subview
                    //self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                    
                   /* for view in self.view.subviews {
                        view.removeFromSuperview()
                    }*/
                // table view 셀이 다 로드 되었을 때를 감지. do here...
                selectGetPlantPidCell()
                    changeLabelName()
                //selectCalendarDate(dateList:ready)
                checkIsLoadedTV = true
                    if CurrentPlantList.count == 1{
                        CurrentPlantList[1] = getplantListFromAddPlantInfoVC[0]
                    }else if(CurrentPlantList.count == 0){
                        CurrentPlantList.append(getplantListFromAddPlantInfoVC[0])
                    }
                }
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (getplantListFromAddPlantInfoVC.count == 0){
            let cell = tableView.cellForRow(at: indexPath) as! ProfileCellTableViewCell
            let pid = Int(cell.pid.text!)
            if CurrentPlantList.count == 1{
                deselectCalendarDate()
                CurrentPlantList[0] = plantsList[pid!]
            }else if(CurrentPlantList.count == 0){
                CurrentPlantList.append(plantsList[pid!])
            }
            selectCalendarDate()
            changeLabelName()
        }
    }
    
    func selectGetPlantPidCell(){
            let indexPath = IndexPath(row: getplantListFromAddPlantInfoVC[0].pid, section: 0)
            plantsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            plantsTableView.delegate?.tableView!(plantsTableView, didSelectRowAt: indexPath)
            print(getplantListFromAddPlantInfoVC[0].pid)
        
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
                let PrivateFrequency = plantObject?["PrivateFrequency"] as? [String: AnyObject]
                let name = plantObject!["name"]
                
                let plants = Plant(Explanation: (Explanation)!,NumericalData:  (NumericalData)!, name: name as! String, pid: count)
                if plantObject?["private_waterDate"] as! [String]! != nil{
                    plants.private_waterDate = plantObject?["private_waterDate"] as! [String]!
                }
                plants.PrivateFrequency = PrivateFrequency
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
        // Dispose of any resources that can be recreated
       
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
}

extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {
    
    func toDate (format: String) -> Date? {
        return DateFormatter(format: format).date(from: self)
    }
    
    func toDateString (inputFormat: String, outputFormat:String) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat).string(from: date)
        }
        return nil
    }
}

extension Date {
    
    func toString (format:String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
}
