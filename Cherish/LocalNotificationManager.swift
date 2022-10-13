//
//  LocalNotificationManager.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/26.
//

import Foundation
import UserNotifications
import StoreKit

struct Notification {
    var id: String
    var title: String
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    static func setNotification() -> Void {
        let key = UserDefaultKey.isAlertSetted.rawValue
        if UserDefaults.standard.object(forKey: key) as? Bool == nil {
            let manager = LocalNotificationManager()
            manager.requestPermission()
            manager.addNotification(title: "Cherish 🫧")
            manager.schedule()
        }
    }
    
    static func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    static func shouldRequestReview() {
        let key = UserDefaultKey.requestReviewCount.rawValue
        
        var requestReviewCount = UserDefaults.standard.object(forKey: key) as? Int ?? 0
        if requestReviewCount == 10 {
            LocalNotificationManager.requestReview()
        }
        requestReviewCount += 1
        UserDefaults.standard.setValue(requestReviewCount, forKey: key)
    }
    
    private func requestPermission() -> Void {
        let key = UserDefaultKey.isAlertSetted.rawValue
        UserDefaults.standard.setValue(true, forKey: key)
        userNotificationCenter
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                    self.scheduleNotifications()
                }
        }
    }
    
    private func addNotification(title: String) -> Void {
        notifications.append(Notification(id: UUID().uuidString, title: title))
    }
    
    private func schedule() -> Void {
        userNotificationCenter.getNotificationSettings { settings in
              switch settings.authorizationStatus {
              case .notDetermined:
                  self.requestPermission()
              case .authorized, .provisional:
                  self.scheduleNotifications()
              default:
                  break
            }
        }
        
    }
    
    private func scheduleNotifications(date: Date? = nil) -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
          
            content.sound = UNNotificationSound.default
            content.body = "오늘의 일기를 작성해보세요 !"
            
            var inputDate = DateComponents()
            
            if let date = date {
                inputDate.hour = date.dateToString_HS().hour
                inputDate.minute = date.dateToString_HS().minute
            } else {
                inputDate.hour = 19
                inputDate.minute = 00
            }
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: inputDate, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            userNotificationCenter.add(request) { error in
                guard error == nil else { return }
            }
        }
    }
}
