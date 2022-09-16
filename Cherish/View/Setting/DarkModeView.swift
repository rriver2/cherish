//
//  DarkModeView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/22.
//

import SwiftUI

struct DarkModeView: View {
    @EnvironmentObject var darkModeViewModel: DarkModeViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var isShowTabbar: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
                .padding(.bottom, 70)
            let darkModeCategoryAll = DarkModeViewModel.Category.allCases
            
            VStack(spacing: 40) {
                ForEach(darkModeCategoryAll, id: \.self) { darkModeCategory in
                    Button {
                        darkModeViewModel.setMode(categoryMode: darkModeCategory)
                    } label: {
                        HStack(spacing: 0) {
                            Text(darkModeCategory.rawValue)
                                .font(darkModeViewModel.isSameMode(categoryMode: darkModeCategory) ? .bodySemibold : .bodyRegular)
                            Spacer()
                            if darkModeViewModel.isSameMode(categoryMode: darkModeCategory) {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray23)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .foregroundColor(.gray23)
        .paddingHorizontal()
        .onAppear {
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension DarkModeView {
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
            Text("다크모드/라이트모드")
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
    }
}

struct DarkModeView_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeView(isShowTabbar: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
