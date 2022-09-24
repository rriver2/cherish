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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            let emotionListString = emotionViewModel.selectedEmotionList.joined(separator: "    ")
            titleView(emotionListString)
            WritingView(date: $emotionViewModel.date, context: $emotionViewModel.context, isEditMode: emotionViewModel.context != "내용")
                .padding(.top, 12)
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
    }
}

extension EmotionView {
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
