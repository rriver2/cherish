//
//  SettingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/22.
//

import SwiftUI

struct SettingView: View {
    @State private var isLockScreen = false
    
    var body: some View {
        VStack(spacing: 48) {
            HStack(spacing: 0) {
                Text("화면 잠금")
                Spacer()
                Image(isLockScreen ? "ToggleOn" : "ToggleOff")
                    .onTapGesture {
                        isLockScreen.toggle()
                    }
            }
            HStack(spacing: 0) {
                Text("다크모드")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            
            HStack(spacing: 0) {
                Text("의견 남기기")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            
            HStack(spacing: 0) {
                Text("친구에게 공유하기")
                Spacer()
                Image(systemName: "chevron.forward")
            }
            
            HStack(spacing: 0) {
                Text("라이센스")
                Spacer()
                Image(systemName: "chevron.forward")
            }
        }
        .padding(.horizontal, 27)
        .foregroundColor(.gray23)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
