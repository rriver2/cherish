//
//  LocalNotificationManager.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/26.
//

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    static func setNotification() -> Void {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        manager.addNotification(title: "Cherish 🫧")
        manager.schedule()
    }
    
    private func requestPermission() -> Void {
        
        userNotificationCenter
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
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
                      let inputDate: Date
                      let key = UserDefaultKey.alertTime.rawValue
                      if let date = UserDefaults.standard.object(forKey: key) as? Date {
                          inputDate = date
                      } else {
                          let date = Date()
                          UserDefaults.standard.setValue(date, forKey: key)
                          inputDate = date
                      }
                  self.scheduleNotifications(date: inputDate)
              default:
                  break
            }
        }
        
    }
    
    static func isAllowedNotificationSetting(completion: @escaping (Bool) -> Void) {
        
        var returnValue = false
        UNUserNotificationCenter.current()
            .getNotificationSettings { notificationSettings in
            switch notificationSettings.authorizationStatus  {
                case .authorized: // 푸시 수신 동의
                    returnValue = true
                    print("returnValue", returnValue)
                case .denied: // 푸시 수신 거부
                    returnValue = false
                case .notDetermined: // 한 번 허용 누른 경우
                    returnValue = false
                case .provisional: // 푸시 수신 임시 중단
                    returnValue = false
                case .ephemeral: // @available(iOS 14.0, *) 푸시 설정이 App Clip에 대해서만 부분적으로 동의한 경우
                    returnValue = false
                @unknown default: // Unknow Status
                    returnValue = false
            }
            // call the completion and pass the result as parameter
            completion(returnValue)
        }

    }
        
    
    private func scheduleNotifications(date: Date) -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
          
            content.sound = UNNotificationSound.default
            content.body = "오늘의 일기를 작성해보세요 !"
            
            var inputDate = DateComponents()
            
            inputDate.hour = date.dateToString_HS().hour
            inputDate.minute = date.dateToString_HS().minute
            
            print(inputDate.hour, inputDate.minute, "로 알림 설정")
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: inputDate, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            userNotificationCenter.add(request) { error in
                guard error == nil else { return }
            }
        }
    }
}
