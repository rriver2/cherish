//
//  EmotionInfoView.swift
//  Cherish
//
//  Created by 이가은 on 2022/10/02.
//

import SwiftUI

struct EmotionInfoView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack (spacing: 0) {
            NavigationBar()
                .padding(.bottom, 50)
            ScrollView {
                Content(title: nil, content: "\" 모호했던 감정에 적절한 이름을 붙이기 위해 고민하다 보면 그 과정에서 나의 마음을 들여다보고 챙길 수 있게 될 거예요. \"")
                    .padding(.bottom, 50)
                Content(title: "내가 느끼고 \"있는\" 감정을 골라보세요.", content: "처음에는 감정을 단어로 표현하는 게 힘들 수도 있지만, 이 과정을 반복하다 보면 내 안의 목소리를 들을 수 있을 거예요. 이 감정들을 통해서 나는 어떤 생각들을 하게 되었는지를 감정을 느끼게 된 상황과 함께 적어보세요. 모호했던 감정들이 좀 더 분명해지고 한결 기분이 개운해질 거예요.")
                    .padding(.bottom, 60)
                Content(title: "내가 느끼고 \"싶은\" 감정을 골라보세요.", content: "어떤 감정을 느끼고 있는지 모르겠는 날에는 내가 느끼고 싶은 감정들을 찾아보세요. 그리고 그 감정을 오늘 하루 느껴보기 위해 어떤 일들을 할 수 있을지에 대해 적어보세요. 이렇게 느끼고 싶은 감정에 초점을 맞추다 보면 자연스럽게 오늘의 나, 본연의 나를 마주할 수 있을 거예요.")
                    .padding(.bottom, 60)
                Spacer()
            }
        }
        .background(Color.grayF5)
    }
}
extension EmotionInfoView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "xmark")
                .font(.bodyRegular)
                .foregroundColor(.clear)
                .padding(.trailing, 18)
            Spacer()
            Text("감정 일기 가이드")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
                    .padding(.trailing, 18)
            }
        }
        .padding(.top, 25)
        .padding(.bottom, 3)
    }
    @ViewBuilder
    private func Content(title: String?, content: String) -> some View {//
        VStack(alignment: .leading, spacing: 0) {
            if let title {
                Text(title)
                    .font(.bodySemibold)
                    .foregroundColor(.gray23)
                    .padding(.bottom, 28)
            }
            Text(content)
                .font(.bodyRegularSmall)
                .foregroundColor(.gray23)
                .lineSpacing(10)
        }
        .paddingHorizontal()
    }
}

struct EmotionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionInfoView()
    }
}
