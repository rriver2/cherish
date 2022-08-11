//
//  TitleView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/11.
//

import SwiftUI

struct TitleView: View {
    let title: String
    var body: some View {
        HStack(spacing: 0) {
            Text(title)
            Spacer()
            SoundView()
        }
        .font(.bigTitle)
        .padding(.bottom, 30)
        .padding(.top, 20)
        .tint(.defaultText)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "임시 제목")
            .environmentObject(SoundViewModel())
    }
}
