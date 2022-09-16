//
//  EmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct EmotionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @ObservedObject var emotionViewModel: EmotionViewModel
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State var isShowAlert = false
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: nil, alignment: .leading),
        GridItem(.flexible(), spacing: nil, alignment: .leading)
    ]
    
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            EmotionGroups()
                .padding(.top, 2)
                .padding(.leading, 5)
            WritingView(date: $emotionViewModel.date, context: $emotionViewModel.context)
                .padding(.top, 25)
        }
        .paddingHorizontal()
        .alert(isPresented: $isShowAlert) {
            emotionViewModel.showEmotionViewAlert(dismiss: dismiss)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                    .font(.bodyRegular)
                Spacer()
                Button {
                    if emotionViewModel.context == "내용" || emotionViewModel.context == "" {
                        isShowAlert = true
                        emotionViewModel.alertCategory = .save
                    } else {
                        let emotionListString = emotionViewModel.selectedEmotionList.joined(separator: "    ")
                        timeLineViewModel.addRecord(date: emotionViewModel.date, title: emotionListString, context: emotionViewModel.context, kind: Record.emotion)
                        addWritingPopupViewModel.isShowAddWritingPopup = true
                        addWritingPopupViewModel.writingCategory = .emotion
                        dismiss()
                        isModalShow = false
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                        .foregroundColor(.gray23)
                        .foregroundColor(.gray23)
                        .font(.bodyRegular)
                }
            }
        }
        .textInputAutocapitalization(.never)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                dismiss()
            }
        })
    }
}

extension EmotionView {
    @ViewBuilder
    private func EmotionGroups() -> some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(emotionViewModel.selectedEmotionList, id: \.self) { detailEmotion in
                    HStack(spacing: 0) {
                        let isSelected = emotionViewModel.selectedEmotionList.contains(detailEmotion)
                        HStack(spacing: 0) {
                            Text(detailEmotion)
                                .frame(alignment: .leading)
                                .font(.bodyRegular)
                                .foregroundColor((colorScheme == .dark && isSelected) ? Color.grayF5: Color.gray23)
                            if isSelected {
                                Image(systemName: "xmark")
                                    .padding(.leading, 7)
                                    .foregroundColor(Color(hex: "747474"))
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(isSelected ? (colorScheme == .dark ? Color.grayEE : Color.grayE8) : .clear)
                        .cornerRadius(15)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if emotionViewModel.selectedEmotionList.count <= 1 {
                            isShowAlert = true
                            emotionViewModel.alertCategory = .leave
                        } else {
                            emotionViewModel.tabEmotion(emotion: detailEmotion)
                        }
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
            Text(Record.emotion.writingMainText)
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Image(systemName: "chevron.left")
                .foregroundColor(.clear)
                .font(.bodyRegular)
        }
        .padding(.bottom, 28)
        .padding(.top, 25)
    }
}

struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(isModalShow: .constant(false), emotionViewModel: EmotionViewModel())
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
