//
//  SettingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var isLockScreen = false
    @Binding var isShowTabbar: Bool
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State private var isShowAlertDelectAll = false
    @State private var isShowAlertConfirmDelectAll = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Title()
                //                HStack(spacing: 0) {
                //                    Text("화면 잠금")
                //                    Spacer()
                //                    Image(isLockScreen ? "ToggleOn" : "ToggleOff")
                //                        .onTapGesture {
                //                            isLockScreen.toggle()
                //                        }
                //                }
                
                NavigationLink {
                    DarkModeView(isShowTabbar: $isShowTabbar)
                } label: {
                    HStack(spacing: 0) {
                        Text("다크모드/라이트모드")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                
                NavigationLink {
                    SelectSoundView(isShowTabbar: $isShowTabbar)
                } label: {
                    HStack(spacing: 0) {
                        Text("음악 변경")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                
                NavigationLink {
                    WritingSequenceView(isShowTabbar: $isShowTabbar)
                } label: {
                    HStack(spacing: 0) {
                        Text("일기 형식 순서")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                
                HStack(spacing: 0) {
                    Text("모든 기록 삭제하기")
                    Spacer()
                }
                .onTapGesture {
                    isShowAlertDelectAll = true
                }
                .padding(.bottom, 60)
                
                
                HStack(spacing: 0) {
                    Text("의견 남기기")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .onTapGesture {
                    moveToCherishAppstoreComment()
                }
                
                HStack(spacing: 0) {
                    Text("친구에게 앱 공유하기")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                .onTapGesture {
                    moveToCherishAppStore()
                }
                
                NavigationLink {
                    LicenseView(isShowTabbar: $isShowTabbar)
                } label: {
                    HStack(spacing: 0) {
                        Text("오픈 소스 라이센스")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 27)
            .foregroundColor(.gray23)
            .alert(isPresented: $isShowAlertDelectAll) {
                Alert(title: Text("정말로 모든 기록을 삭제할까요?"), message: Text("삭제하신 이후에는 복원할 수 없습니다."), primaryButton: .destructive(Text("삭제"), action: {
                    timeLineViewModel.removeAll()
                    isShowAlertConfirmDelectAll = true
                }), secondaryButton: .cancel(Text("취소")))
            }
            .alert(isPresented: $isShowAlertConfirmDelectAll) {
                return Alert(title: Text("모든 기록이 삭제되었습니다."), message: nil, dismissButton: .cancel(Text("확인")))
            }
        }
    }
    func moveToCherishAppStore() {
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
    
    func moveToCherishAppstoreComment() {
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
        .padding(.bottom, 40)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
        .background(colorScheme == .light ? .white: .black)
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
