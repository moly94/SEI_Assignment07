//
//  ViewController.swift
//  Assignment07
//
//  Created by Student on 01/02/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    var isGrantedNotificationAccess:Bool = false
    
    let center = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swift
        let options: UNAuthorizationOptions = [.alert, .sound];
        
        // Swift
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }

        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSendNotification(_ sender: UIButton) {
        if isGrantedNotificationAccess {
            let content = UNMutableNotificationContent()
            content.title="Start Wars"
            content.subtitle="Character"
            content.body="Obi Wan"
            //content.categoryIdentifier="message"
            content.sound=UNNotificationSound.default()
            
            
            let trigger = UNTimeIntervalNotificationTrigger( timeInterval: 10.0, repeats: false)
            
            let request = UNNotificationRequest(identifier: "60.second.message", content:content, trigger: trigger )
            
            
            let badAction = UNNotificationAction(identifier: "Bad", title: "Bad", options: [])
            
            let goodAction = UNNotificationAction(identifier: "Good", title: "Good", options: [.destructive])
            
            let category = UNNotificationCategory(identifier: "Starwars", actions: [goodAction, badAction], intentIdentifiers: [], options: [])
            
            
            content.categoryIdentifier="Starwars"
            center.add(request, withCompletionHandler: nil)
            
            center.setNotificationCategories([category])
            
            
        }
        
    }
    
}

