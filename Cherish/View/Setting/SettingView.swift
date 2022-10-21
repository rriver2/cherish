//
//  SettingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isShowTabbar: Bool
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @StateObject var settingViewModel = SettingViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Title()
                ScrollView {
                    VStack(spacing: 15) {
                        NavigationLink {
                            DarkModeView(isShowTabbar: $isShowTabbar)
                        } label: {
                            HStack(spacing: 0) {
                                Text("다크모드/라이트모드")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .padding(.bottom, 15)
                        }
                        
                        NavigationLink {
                            SelectSoundView(isShowTabbar: $isShowTabbar)
                        } label: {
                            HStack(spacing: 0) {
                                Text("음악 변경")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .padding(.bottom, 15)
                        }
                        
                        NavigationLink {
                            WritingSequenceView(isShowTabbar: $isShowTabbar)
                        } label: {
                            HStack(spacing: 0) {
                                Text("일기 형식 순서 변경")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .padding(.bottom, 15)
                        }
                        
                        HStack(spacing: 0) {
                            Text("모든 기록 삭제하기")
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            settingViewModel.alertCategory = .remove
                            settingViewModel.isShowAlert = true
                        }
                        .padding(.bottom, 60)
                        
                        
                        HStack(spacing: 0) {
                            Text("앱 별점 남기기")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.bottom, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            ReviewManager.requestReview()
                        }
                        
                        HStack(spacing: 0) {
                            Text("의견 및 피드백 남기기")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.bottom, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            moveToCherishAppstoreComment()
                        }
                        
                        HStack(spacing: 0) {
                            Text("친구에게 앱 공유하기")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.bottom, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            moveToCherishAppStore()
                        }
                        
                        HStack(spacing: 0) {
                            Text("공식 인스타그램")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                        .padding(.bottom, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            openInstargram()
                        }
                        
                        NavigationLink {
                            LicenseView(isShowTabbar: $isShowTabbar)
                        } label: {
                            HStack(spacing: 0) {
                                Text("오픈 소스 라이센스")
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }
                            .padding(.bottom, 15)
                        }
                    }
                }
            }
            .paddingHorizontal()
            .foregroundColor(.gray23)
            .alert(isPresented: $settingViewModel.isShowAlert) {
                switch settingViewModel.alertCategory {
                    case .remove:
                        return Alert(title: Text("정말로 모든 기록을 삭제할까요?"), message: Text("삭제하신 이후에는 복원할 수 없습니다."), primaryButton: .destructive(Text("삭제"), action: {
                            timeLineViewModel.removeAll()
                            settingViewModel.isShowAlertConfirmDelectAll = true
                        }), secondaryButton: .cancel(Text("취소")))
                    case .notificationPermissions:
                        return Alert(title: Text("알람 설정"), message: Text("설정에서 알림을 허용한 후 앱을 다시 실행해주세요!"), dismissButton: .cancel(Text("확인")))
                }
            }
            .onChange(of: settingViewModel.isShowAlert) { newValue in
                if settingViewModel.isShowAlert == false && settingViewModel.alertCategory == .notificationPermissions {
                    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
    private func moveToCherishAppStore() {
        if let  urlShare = URL(string:"https://apps.apple.com/us/app/cherish/id1639908764") {
            let text = "cherish - 나를 들여다보는 시간 🫧"
            let activityVC = UIActivityViewController(activityItems: [urlShare, text], applicationActivities: nil)
            let allScenes = UIApplication.shared.connectedScenes
            let scene = allScenes.first { $0.activationState == .foregroundActive }
            
            if let windowScene = scene as? UIWindowScene {
                windowScene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
    private func moveToCherishAppstoreComment() {
        if let appstoreUrl = URL(string: "https://apps.apple.com/us/app/cherish/id1639908764") {
            var urlComp = URLComponents(url: appstoreUrl, resolvingAgainstBaseURL: false)
            urlComp?.queryItems = [
                URLQueryItem(name: "action", value: "write-review")
            ]
            guard let reviewUrl = urlComp?.url else {
                return
            }
            UIApplication.shared.open(reviewUrl, options: [:], completionHandler: nil)
        }
    }
    
    private func openInstargram() {
        let screenName =  "ch._.erish_official"
        
        let appURL = URL(string:  "instagram://user?username=\(screenName)")
        let webURL = URL(string:  "https://instagram.com/\(screenName)")
        
        if let appURL, UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
        } else if let webURL{
            // redirect to safari because the user doesn't have Instagram
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(webURL)
            }
        }
    }
}

extension SettingView {
    @ViewBuilder
    private func Title() -> some View {
        HStack(spacing: 0) {
            Text("설정")
                .foregroundColor(Color.gray23)
                .padding(.leading, 3)
            Spacer()
        }
        .frame(height: 20)
        .padding(.bottom, getDeviceScreenHeight() == .small ? 26 : 72)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
        .contentShape(Rectangle())
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isShowTabbar: .constant(true))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
