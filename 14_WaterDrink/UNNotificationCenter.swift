//
//  UNNotificationCenter.swift
//  14_WaterDrink
//
//  Created by 이윤수 on 2022/05/26.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNofi(alert: Alert){
        let content = UNMutableNotificationContent()
        content.title = "물을 마실 시간이에요 💧"
        content.body = alert.msg
        content.sound = .default
        content.badge = 1
        
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
