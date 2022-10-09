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
    @Published var alertCategory: AlertCategory = .remove
    @Published var isShowAlert = false
    @Published var isExistNotification: Bool = false
    
    enum AlertCategory {
        case remove
        case notificationPermissions
    }
}
