//
//  AppDelegate.swift
//  IAMGROOT
//
//  Created by 김지영 on 2018. 10. 15..
//  Copyright © 2018년 김지영. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseUI
import GoogleSignIn 
import GoogleMaps
import GooglePlaces
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate  {
 
    var  plantsList = [Plant]()//all plantlist
    
    var window: UIWindow? 
    func prepareloginScene(){
        let loginScene = UIStoryboard(name: "FBLoginConnectPageViewController", bundle:nil).instantiateViewController(withIdentifier: "FBLoginConnectPageViewController") as UIViewController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = loginScene
    }
    func prepareMainViewController(){
        let MainViewController = UIStoryboard(name: "MainViewController", bundle:nil).instantiateViewController(withIdentifier: "MainTabBarController") as UIViewController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = MainViewController
    }
    func setFirstPageManager(){
        if Auth.auth().currentUser == nil {
            prepareloginScene()
        } else {
            self.setUserProfile()
            self.sendNewUserFirebaseRealtimeDB()
            prepareMainViewController()
            self.setPlantsListModel()
        }
    }
    func setUserProfile(){
        let user = Auth.auth().currentUser
        User.uid = (user?.uid)!
        User.email = (user?.email)!
        User.phoneNum = (user?.phoneNumber)
        User.accessibilityLanguage = (user?.accessibilityLanguage)
        User.name = (user?.displayName)!
        //let photoURL = user.photoURL
        
    }
    func sendNewUserFirebaseRealtimeDB(){
        var ref: DatabaseReference!
        ref = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
        ref.child("users").child(User.uid).child("profile").setValue(["uid": User.uid,"email": User.email,"phoneNum": User.phoneNum, "name": User.name, "accessibilityLanguage": User.accessibilityLanguage])
        
    }
    func setPlantsListModel(){
        var refUser: DatabaseReference!
        
        refUser = Database.database(url: "https://atticyadmin-10a61.firebaseio.com/").reference()
         refUser.child("users").child(User.uid).child("MyPlants").observe(DataEventType.value, with: { (snapshot) in
            
            self.plantsList.removeAll()
            var count = 0
            var userDefaultWouldWaterDatePlantList = [String]()
            var userDefaultWouldWaterDatePlantNameList = [String]()
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
                if plantObject?["private_wouldWaterDate"] as! String! != nil{
                    plants.private_wouldWaterDate = plantObject?["private_wouldWaterDate"] as! String!
                    userDefaultWouldWaterDatePlantList.append(plants.private_wouldWaterDate)
                    userDefaultWouldWaterDatePlantNameList.append(name as! String)
                   
                    
                    
                }
                plants.PrivateFrequency = PrivateFrequency
                self.plantsList.append(plants)
                count += 1
            }
            if let userDefaults = UserDefaults(suiteName: "group.com.kjy.IAMGROOT"){
                userDefaults.set(userDefaultWouldWaterDatePlantList, forKey: "userDefaultWouldWaterDatePlantList")
                userDefaults.set(userDefaultWouldWaterDatePlantNameList, forKey: "userDefaultWouldWaterDatePlantNameList")
                userDefaults.synchronize()
            
            }
            if let userDefaults = UserDefaults(suiteName: "group.com.kjy.IAMGROOT"){
                let userDefaultWouldWaterDatePlantList = userDefaults.stringArray(forKey: "userDefaultWouldWaterDatePlantList") ?? [String]()
                let userDefaultWouldWaterDatePlantNameList = userDefaults.stringArray(forKey: "userDefaultWouldWaterDatePlantNameList") ?? [String]()
                print("#")
                print(userDefaultWouldWaterDatePlantList)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func googleMapSettingManager(){
        //google map
        GMSServices.provideAPIKey("AIzaSyALHhSpSP4KFGXrTgMbPUq7oeoxZ-98O5k")
        GMSPlacesClient.provideAPIKey("AIzaSyALHhSpSP4KFGXrTgMbPUq7oeoxZ-98O5k")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //setting siginin
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        setFirstPageManager()
        
        //setting google map
        googleMapSettingManager()
        
        return true
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+"\(credential)")
        // . Firebase 사용자 인증 정보를 사용해 Firebase에 인증합니다..
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                return
            }
            // User is signed in
            self.setFirstPageManager()
            print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+"\(credential)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "IAMGROOT")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

