//
//  DarkModeViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/23.
//

import SwiftUI

class DarkModeViewModel: ObservableObject {
    @Published var mode: ColorScheme?
    
    enum Category: String, CaseIterable {
        case dark = "다크모드"
        case light = "라이트모드"
        case none = "디바이스 환경설정 모드"
    }
    
    func isSameMode(categoryMode: Category) -> Bool {
        switch categoryMode {
            case .light:
                return mode == .light
            case .dark:
                return mode == .dark
            case .none:
                return mode == nil
        }
    }
    
    static func colorSchemeString(mode: ColorScheme) -> String {
        switch mode {
            case .light:
                return "Light"
            case .dark:
                return "Dark"
            @unknown default:
                return "Light"
        }
    }
    
    func setMode(categoryMode: Category) {
        let key = UserDefaultKey.darkMode.string
        switch categoryMode {
            case .light:
                UserDefaults.standard.set(categoryMode.rawValue, forKey: key)
                mode = .light
            case .dark:
                UserDefaults.standard.set(categoryMode.rawValue, forKey: key)
                mode = .dark
            case .none:
                UserDefaults.standard.set(categoryMode.rawValue, forKey: key)
                mode = nil
        }
    }
    
    
    func geColorScheme(mode: String) -> ColorScheme? {
        switch mode {
            case Category.dark.rawValue:
                return .dark
            case Category.light.rawValue:
                return .light
            case Category.none.rawValue:
                return nil
            default:
                return nil
        }
    }
    
    init(mode: ColorScheme? = nil) {
        let key = UserDefaultKey.darkMode.string
        let darkModeCategory = UserDefaults.standard.object(forKey: key) as? String ?? ""
        self.mode = geColorScheme(mode: darkModeCategory)
    }
}
