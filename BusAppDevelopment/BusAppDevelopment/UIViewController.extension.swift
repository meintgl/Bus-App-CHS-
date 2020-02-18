//
//  UIViewController.extension.swift
//  BusAppDevelopment
//
//  Created by Meinhard Benedict Capucao on 2/6/20.
//  Copyright © 2020 Meinhard Benedict Capucao. All rights reserved.
//

import UIKit
import UserNotifications

extension UIViewController {
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //print("User Notification settings: (settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func requestNotificationAuthorization(){
        // Request for permissions
        UNUserNotificationCenter.current()
            .requestAuthorization(
            options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                //print("Notification granted: (granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
}
