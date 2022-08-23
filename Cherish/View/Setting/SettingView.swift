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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 48) {
                Title()
                HStack(spacing: 0) {
                    Text("화면 잠금")
                    Spacer()
                    Image(isLockScreen ? "ToggleOn" : "ToggleOff")
                        .onTapGesture {
                            isLockScreen.toggle()
                        }
                }
                
                NavigationLink {
                    DarkModeView(isShowTabbar: $isShowTabbar)
                } label: {
                    HStack(spacing: 0) {
                        Text("다크모드")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                
                HStack(spacing: 0) {
                    Text("의견 남기기")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                
//                HStack(spacing: 0) {
//                    Text("친구에게 공유하기")
//                    Spacer()
//                    Image(systemName: "chevron.forward")
//                }
//                .onTapGesture {
//                    actionSheet()
//                }
                
                HStack(spacing: 0) {
                    Text("라이센스")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                Spacer()
            }
            .padding(.horizontal, 27)
            .foregroundColor(.gray23)
        }
    }
//    func actionSheet() {
//        guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
//        let text = "cherish - 나를 들여다보는 시간 🫧"
//        let activityVC = UIActivityViewController(activityItems: [urlShare, text], applicationActivities: nil)
//        let allScenes = UIApplication.shared.connectedScenes
//        let scene = allScenes.first { $0.activationState == .foregroundActive }
//
//        if let windowScene = scene as? UIWindowScene {
//            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
//        }
//    }
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
        .padding(.bottom, 31)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
        .background(colorScheme == .light ? .white: .black)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isShowTabbar: .constant(true))
    }
}
