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
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            ScrollView (showsIndicators : false) {
                EmotionGroups()
                    .padding(.top, 30)
                WritingView(context: $context)
                    .padding(.top, 25)
            }
            .padding(.horizontal, 27)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                    .font(.bodyRegular)
                Spacer()
                Button {
                    let emotionListString = emotionList.joined(separator: "    ")
                    timeLineViewModel.addRecord(date: Date(), title: emotionListString, context: context, kind: Record.emotion)
                    dismiss()
                    isModalShow = false
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.gray23)
                        .font(.bodyRegular)
                }
            }
        }
        .textInputAutocapitalization(.never)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionList)
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                dismiss()
            }
        })
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
        VStack(spacing: 0) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(emotionList, id: \.self) { detailEmotion in
                    HStack(spacing: 0) {
                        let isSelected = emotionList.contains(detailEmotion)
                        HStack(spacing: 0) {
                            Text(detailEmotion)
                                .frame(alignment: .leading)
                                .font(.bodyRegular)
                                .foregroundColor(Color.gray23)
                            if isSelected {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(hex: "747474"))
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
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
        }
    }
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
            }
            Spacer()
        }
        .padding(.top, 25)
        .padding(.horizontal, 27)
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(emotionList: .constant(["재미있다", "상쾌하다", "신나다", "활기가 넘치다", "희망을 느끼다", "기대되다"]), isModalShow: .constant(false), context: .constant("내용"))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
    }
}
