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
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
                .paddingHorizontal()
            dividerThick2(colorScheme)
            VStack(alignment: .leading, spacing: 0) {
                ForEach(SoundCategory.allCases, id: \.self) { sound in
                    if let context = sound.license {
                        LicenseText(title: "music - \(sound.displayName)", context: context)
                    }
                }
            }
                .padding(.vertical, 28)
            Spacer()
        }
        .onAppear {
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
        }
        .navigationBarBackButtonHidden(true)
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
            Rectangle()
                .frame(width: 13, height: 9)
                .font(.bodyRegular)
                .foregroundColor(.clear)
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .padding(.bottom, 40)
    }
    @ViewBuilder
    private func LicenseText(title: String, context: String) -> some View {
        Text(title)
            .font(.bodyRegular)
            .foregroundColor(.gray23)
            .padding(.bottom, 11)
            .paddingHorizontal()
        Text(context)
            .font(.miniRegular)
            .tint(.gray8A)
            .foregroundColor(.gray8A)
            .paddingHorizontal()
        divider(colorScheme)
            .padding(.vertical, 24)
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
