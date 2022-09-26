//
//  ContentView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

enum OnBoardingCategory: String {
    case firstTime = "Onboarding"
    case update = "Upadate"
    
    var imageCount: Int {
        switch self {
            case .firstTime:
                return 6
            case .update:
                return 1
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var darkModeViewModel: DarkModeViewModel
    @State var isShowOnboarding: Bool
    let onBoardingCategory: OnBoardingCategory
    
    init() {
        self._isShowOnboarding = State(initialValue: true)
        let nowVersion: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? nil
        
        if let preVersion = UserDefaults.standard.object(forKey: UserDefaultKey.versionRecord.rawValue) as? String {
            if nowVersion == preVersion {
                self.onBoardingCategory = .update
                self._isShowOnboarding = State(initialValue: false)
            } else {
                // 기존에 다운 받았지만, 업데이트가 안 된 유저
                // 다음 스프린트부터 여기
                self.onBoardingCategory = .update
                self._isShowOnboarding = State(initialValue: true)
            }
        } else {
            // sprint 3 부터는 새로 다운 받은 유저로 처리 (else 이후 모두 삭제 후 새로 다운 받은 유저 처리)
            let isShowOnboarding = UserDefaults.standard.object(forKey: UserDefaultKey.isShowOnboarding.rawValue) as? Bool ?? true
            if isShowOnboarding {
                // 새로 다운 받은 유저
                self.onBoardingCategory = .firstTime
                self._isShowOnboarding = State(initialValue: true)
                
            } else {
                // 기존에 다운 받았지만, 업데이트가 안 된 유저 ( 이번 스프린트만 존재 )
                self.onBoardingCategory = .update
                self._isShowOnboarding = State(initialValue: true)
            }
        }
        UserDefaults.standard.set(nowVersion, forKey: UserDefaultKey.versionRecord.rawValue)
    }
    
    var body: some View {
        if isShowOnboarding {
            OnboardingView(isShowOnboarding: $isShowOnboarding, onBoardingCategory: onBoardingCategory )
                .preferredColorScheme(darkModeViewModel.mode)
        } else {
            MainView()
        }
    }
}

