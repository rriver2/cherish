//
//  EmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct EmotionView: View {
    @Binding var emotionList: [String]
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @Binding var context: String
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    private let columns = [
        GridItem(.flexible(), spacing: nil, alignment: .leading),
        GridItem(.flexible(), spacing: nil, alignment: .leading)
    ]
    
    var body: some View {
        ScrollView {
            EmotionGroups()
            WritingView(context: $context)
        }
        .padding(.horizontal, 20)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                Spacer()
                Button {
                    let emotionListString = emotionList.joined(separator: "    ")
                    timeLineViewModel.addRecord(date: Date(), title: emotionListString, context: context, kind: Record.emotion)
                    dismiss()
                    isModalShow = false
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .textInputAutocapitalization(.never)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionList)
        .tint(Color.gray23)
    }
    private func tabEmotion(emotion: String) {
        if let index = emotionList.firstIndex(of: emotion) {
            emotionList.remove(at: index)
        } else {
            emotionList.append(emotion)
        }
    }
}

extension EmotionView {
    @ViewBuilder
    private func EmotionGroups() -> some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(emotionList, id: \.self) { detailEmotion in
                    HStack {
                        let isSelected = emotionList.contains(detailEmotion)
                        HStack {
                            Text(detailEmotion)
                                .frame(alignment: .leading)
                                .font(.mainText)
                            if isSelected {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(hex: "747474"))
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(isSelected ? Color.grayE8 : .clear)
                        .cornerRadius(15)
                        Spacer()
                    }
                    .background(.white)
                    .onTapGesture {
                        tabEmotion(emotion: detailEmotion)
                    }
                }
            }
            .padding(.bottom, 25)
        }
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(emotionList: .constant(["재미있다", "상쾌하다", "신나다", "활기가 넘치다", "희망을 느끼다", "기대되다"]), isModalShow: .constant(false), context: .constant("내용"))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
    }
}
