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
            Content(title: "오늘 내가 느끼고 있는 감정을 골라보세요.", content: "처음에는 세밀한 감정들을 찾아내는 게 힘들 수도 있지만, 이 과정을 반복하다 보면 내 안의 목소리를 들을 수 있을 거예요. 왜 이런 감정들을 느꼈는지 이 감정들을 통해서 나는 어떤 생각들을 하게 되었는지 적어보세요.")
            Content(title: "내가 느끼고 싶은 감정을 골라보세요.", content: "나의 감정을 마주하고 싶지 않거나, 어떤 감정을 느끼고 있는지 잘 모르겠는 날에는 이렇게 내가 느끼고 싶은 감정들을 찾아보는 게 도움이 될 수 있답니다. 이 감정들을 느끼고 싶은 이유가 무엇인지, 어떻게 하면 이런 감정을 느낄 수 있을지 작성해보세요.")
            Spacer()
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
    private func Content(title: String, content: String) -> some View {//
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.bodySemibold)
                .foregroundColor(.gray23)
                .padding(.bottom, 28)
            Text(content)
                .font(.bodyRegularSmall)
                .foregroundColor(.gray23)
                .lineSpacing(12)
        }
        .padding(.top, 60)
        .paddingHorizontal()
    }
}

struct EmotionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionInfoView()
    }
}
