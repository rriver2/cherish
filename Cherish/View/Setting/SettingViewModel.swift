//
//  SettingViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/28.
//

import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var isLockScreen = false
    @Published var isShowAlertConfirmDelectAll = false
    @Published var alertTime: Date
    @Published var alertCategory: AlertCategory = .remove
    @Published var isShowAlert = false
    @Published var isExistNotification: Bool = false
    
    enum AlertCategory {
        case remove
        case notificationPermissions
    }
    
    init() {
        let key = UserDefaultKey.alertTime.rawValue
        if let date = UserDefaults.standard.object(forKey: key) as? Date {
            self.alertTime = date
        } else {
            let date = Date()
            UserDefaults.standard.setValue(date, forKey: key)
            self.alertTime = date
        }
    }
    
//    func setNotification() {
//        LocalNotificationManager.isAllowedNotificationSetting { isNotDetermined in
//                DispatchQueue.main.async { [weak self] in
//                    self?.isExistNotification = isNotDetermined
//                }
//        }
//    }
}
