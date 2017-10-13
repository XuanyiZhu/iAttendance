//
//  AppDelegate.swift
//  iAttendance
//
//  Created by Prasidha Timsina on 10/12/17.
//  Copyright © 2017 Prasidha Timsina. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTMonitoringV2ManagerDelegate {

    var window: UIWindow?
    var monitoringManager: ESTMonitoringV2Manager!
    var ref: DatabaseReference!
    
    
    var netID = "Ptimsin2"
    var attendance = "Present"
    var studentName = "Prasidha Timsina"

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        ref = Database.database().reference()

        
        ESTConfig.setupAppID("iattendance-jyb", andAppToken: "9ac55f428f71028d08ca2c500536580c")

        
        self.monitoringManager = ESTMonitoringV2Manager(
            desiredMeanTriggerDistance: 200.0, delegate: self)
        self.monitoringManager.startMonitoring(forIdentifiers: [
            "2fe9f9eab6f63a83403d83d5fdd5f338",
            "600b8a212b5931dd7dc79b47566a032f"])
        
        
        return true
    }
    
    func sendDataToDatabase(){
        self.ref.child("NetID")
        self.ref.child("NetID").child(netID)
        self.ref.child("NetID").child(netID).setValue(["Attendance: \(attendance) ", "Name: \(studentName)"])
        print("SUCESSS ------------------------------------")
        
    }
    
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didEnterDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didEnter proximity of beacon \(identifier)")
        print("This is where the data would get sent!")
        sendDataToDatabase()
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didExitDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didExit proximity of beacon \(identifier)")
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didDetermineInitialState state: ESTMonitoringState,
                           forBeaconWithIdentifier identifier: String) {
        // state codes: 0 = unknown, 1 = inside, 2 = outside
        print("didDetermineInitialState '\(state)' for beacon \(identifier)")
    }
    
    func monitoringManagerDidStart(_ manager: ESTMonitoringV2Manager) {
        print("monitoringManagerDidStart")
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didFailWithError error: Error) {
        print("monitoringManager didFailWithError: \(error.localizedDescription)")
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
    }


}

