//
//  MainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/26.
//

import SwiftUI

struct MainView: View {
    @State var tabbarCategory: TabbarCategory = .writing
    @State var isShowTabbar = true
    @EnvironmentObject var darkModeViewModel: DarkModeViewModel
    
    var body: some View {
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
                        VStack(spacing: 0) {
                            Image(systemName: tabbarItem.imageName)
                                .font(.system(size: 20, weight: .regular))
                                .padding(.bottom, 2)
                            Text(tabbarItem.rawValue)
                                .font(.system(size: 10, weight: .regular))
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 15)
                        .foregroundColor(tabbarCategory == tabbarItem ? Color.gray23 : (darkModeViewModel.mode != .dark ? Color.grayA7 : Color.grayE8))
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
        .onAppear {
            LocalNotificationManager.setNotification()
            LocalNotificationManager.shouldRequestReview()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
