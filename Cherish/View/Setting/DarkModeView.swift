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
        VStack(spacing: 48) {
            NavigationBar()
                .padding(.bottom, 28)
            let darkModeCategoryAll = DarkModeViewModel.Category.allCases
            
            ForEach(darkModeCategoryAll, id: \.self) { darkModeCategory in
                HStack(spacing: 0) {
                    Text(darkModeCategory.rawValue)
                        .font(darkModeViewModel.isSameMode(categoryMode: darkModeCategory) ? .bodySemibold : .bodyRegular)
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(darkModeViewModel.isSameMode(categoryMode: darkModeCategory) ? .gray23 : .clear)
                }
                .onTapGesture {
                    darkModeViewModel.setMode(categoryMode: darkModeCategory)
                }
            }
            Spacer()
        }
        .foregroundColor(.gray23)
        .padding(.horizontal, 27)
        .onAppear {
            isShowTabbar = false
        }
    }
}

extension DarkModeView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
                isShowTabbar = true
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyRegular)
            }
            Spacer()
            Text("다크모드")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Image(systemName: "checkmark")
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
            .environmentObject(DarkModeViewModel())
    }
}
