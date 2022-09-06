//
//  LicenseView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/23.
//

import SwiftUI

struct LicenseView: View {
    @Binding var isShowTabbar: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            dividerThickGrayE8
            VStack(alignment: .leading, spacing: 0) {
            Text("music")
                .font(.bodyRegular)
                .foregroundColor(.gray23)
                .padding(.bottom, 11)
            Text("Cozy Place by Keys of Moon | https://soundcloud.com/keysofmoon Music promoted by https://www.chosic.com/free-music/all/   Creative Commons CC BY 4.0m https://creativecommons.org/licenses/by/4.0/")
                .font(.miniRegular)
                .tint(.gray8A)
                .foregroundColor(.gray8A)
            }
                .padding(.vertical, 28)
            dividerGrayE8
            Spacer()
        }
        .padding(.horizontal, 27)
        .onAppear {
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
        }
    }
}

extension LicenseView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyRegular)
            }
            Spacer()
            Text("오픈 소스 라이센스")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Image("check")
                .resizable()
                .scaledToFill()
                .frame(width: 13, height: 9)
                .font(.bodyRegular)
                .foregroundColor(.clear)
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .padding(.bottom, 40)
    }
}

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView(isShowTabbar: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
