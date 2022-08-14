//
//  EmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct EmotionView: View {
    let emotionList: [String]
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            EmotionGroups()
            WritingView()
        }
        .padding(.horizontal, 20)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                // TODO: make isMusicOn as Environment object
                MusicView(isMusicOn: .constant(false))
                Spacer()
                Button {
                    // TODO: 저장 로직 추가
                    dismiss()
                    isModalShow = false
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .textInputAutocapitalization(.never)
    }
}

extension EmotionView {
    @ViewBuilder
    private func EmotionGroups() -> some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(emotionList, id: \.self) { emotion in
                    if emotion == emotionList.last {
                        Text(emotion)
                            .padding(.vertical, 10)
                            .font(.mainText)
                    } else {
                        Text("\(emotion), ")
                            .padding(.vertical, 10)
                            .font(.mainText)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: 50)
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(emotionList: ["재미있다", "상쾌하다", "신나다", "활기가 넘치다", "희망을 느끼다", "기대되다", "흥미롭다", "생기가 돌다", "다정하다", "반갑다", "끌리다", "짜릿하다", "개운하다", "좋아하다", "자신있다"], isModalShow: .constant(false))
    }
}
