//
//  ContentView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct ContentView: View {
    @State var tabbarCategory: TabbarCategory = .writing
    @State var isShowTabbar = true
    @EnvironmentObject var darkModeViewModel: DarkModeViewModel
    @State var isShowOnboarding = (UserDefaults.standard.object(forKey: UserDefaultKey.isShowOnboarding.string) as? Bool ?? true)
    
    var body: some View {
        if isShowOnboarding {
            OnboardingView(isShowOnboarding: $isShowOnboarding)
                .preferredColorScheme(darkModeViewModel.mode)
        } else {
        VStack {
            ZStack {
                switch tabbarCategory {
                    case .writing:
                        WritingMainView(isShowTabbar: $isShowTabbar, tabbarCategory: $tabbarCategory)
                    case .timeline:
                        TimelineView()
                    case .setting:
                        SettingView(isShowTabbar: $isShowTabbar)
                }
            }
            .accentColor(Color.gray23)
            if isShowTabbar {
            HStack {
                Spacer()
                Spacer()
                ForEach(TabbarCategory.allCases.indices, id: \.self) { index in
                    let tabbarItem = TabbarCategory.allCases[index]
                    if index != 0 {
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Image(systemName: tabbarItem.imageName)
                            .font(.system(size: 20, weight: .regular))
                        Text(tabbarItem.rawValue)
                            .font(.system(size: 10, weight: .regular))
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    .foregroundColor(tabbarCategory == tabbarItem ? Color.gray23 : (darkModeViewModel.mode == .light ? Color.grayA7 : Color.grayE8))
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                tabbarCategory = tabbarItem
                            }
                    )
                }
                Spacer()
                Spacer()
            }
            }
        }
            .preferredColorScheme(darkModeViewModel.mode)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
    }
}
