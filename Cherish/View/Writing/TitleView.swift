//
//  TitleView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/11.
//

import SwiftUI

struct TitleView: View {
    let title: String
    let isShowSoundView: Bool
    
    init(title: String, isShowSoundView: Bool = true) {
        self.title = title
        self.isShowSoundView = isShowSoundView
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
            Spacer()
            if isShowSoundView {
                SoundView()
            }
        }
        .foregroundColor(Color.gray23)
        .font(.bigTitle)
        .padding(.bottom, 30)
        .padding(.top, 20)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "임시 제목")
            .environmentObject(SoundViewModel())
    }
}
