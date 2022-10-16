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
                return 4
        }
    }
}

//enum UpdateCase {
//    case firstDownload
//    case Newfunction
//
//    var isNeededToUpdate: UpdateCase {
//        if 1 {
//            return .firstDownload
//        }
//    }
//}


struct ContentView: View {
    @EnvironmentObject var darkModeViewModel: DarkModeViewModel
    @State var isShowOnboarding: Bool
    let onBoardingCategory: OnBoardingCategory
    
    init() {
        self._isShowOnboarding = State(initialValue: true)
        let nowVersion: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? nil
        
        if let _ = UserDefaults.standard.object(forKey: UserDefaultKey.isShowOnboarding.rawValue) as? Bool {
            self.onBoardingCategory = .update
            if let preVersion = UserDefaults.standard.object(forKey: UserDefaultKey.versionRecord.rawValue) as? String {
                if nowVersion == preVersion {
                    // 제일 최신 버전인 유저
                    self._isShowOnboarding = State(initialValue: false)
                } else {
                    // 최근 업데이트를 한 유저 -> onBoarding 나와야함
                    self._isShowOnboarding = State(initialValue: true)
                }
            } else {
                // 첫 다운로드가 마지막인 유저
                self._isShowOnboarding = State(initialValue: true)
            }
        } else {
            // 처음 앱을 다운 받은 유저
            self.onBoardingCategory = .firstTime
            self._isShowOnboarding = State(initialValue: true)
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

