//
//  SelectingEmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct SelectingEmotionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @StateObject var emotionViewModel = EmotionViewModel()
    @Binding var isModalShow: Bool
    @State private var isShowNextView = false
    @State private var isShowAlertDelete = false
    @GestureState private var dragOffset = CGSize.zero
    
    @FocusState private var isKeyboardOpen: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                ScrollView(.horizontal, showsIndicators: false) {
                    SelectEmotionType()
                        .padding(.top, 50)
                }
                ScrollView(showsIndicators: false) {
                    EmotionList()
                        .padding(.bottom, 24)
                        .padding(.top, 13)
                }
            }
        }
        .alert(isPresented: $emotionViewModel.isShowAlert) {
            Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                dismiss()
            }), secondaryButton: .cancel(Text("취소")))
        }
        .alert(emotionViewModel.selectedEmotionList == [] ? "감정을 한 개 이상 선택해주세요" : "6개 이하로 선택해주세요", isPresented: $emotionViewModel.isShowAlert) {
            Button("OK", role: .cancel) { }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.translation.height > 100) {
                #warning("수정해야 함..ㅠㅠ")
                //                if selectedEmotion.isEmpty {
                dismiss()
                //                } else {
                //                    isShowAlertDelete = true
                //                }
            }
        })
        .alert(isPresented: $isShowAlertDelete) {
            Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                dismiss()
            }), secondaryButton: .cancel(Text("취소")))
        }
        .animation(Animation.easeInOut(duration: 0.4), value: emotionViewModel.emotionType)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
    }
}

extension SelectingEmotionView {
    @ViewBuilder
    private func SelectEmotionType() -> some View {
        ZStack(alignment: .bottom){
            dividerThickGrayE8
            HStack(alignment: .top, spacing: 0) {
                let emotionList = EmotionCategory.allCases
                ForEach(emotionList.indices, id: \.self) { index in
                    let emotion = emotionList[index]
                    Button(action: {
                        emotionViewModel.emotionType = emotion
                    }) {
                        if(emotionViewModel.emotionType != emotion){
                            Text(emotion.string)
                                .font(.bodyRegular)
                                .foregroundColor(Color.grayA7)
                                .frame(width: UIScreen.main.bounds.width / 4.2 - 20)
                        } else {
                            VStack(spacing: 8) {
                                Text(emotion.string)
                                    .font(.bodySemibold)
                                    .foregroundColor(Color.gray23)
                                dividerThickGray8A
                            }
                            .frame(width: UIScreen.main.bounds.width / 4.2 - 20)
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func EmotionList() -> some View {
        if let emotionList = EmotionData.list[emotionViewModel.emotionType]?.sorted() {
            ForEach(emotionList.indices, id : \.self){ index in
                let detailEmotion = emotionList[index]
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
                    .padding(.top, 18)
                    .padding(.leading, 27)
                    Spacer()
                }
                .background(colorScheme == .light ? .white: .black)
                .onTapGesture {
                    emotionViewModel.tabEmotion(emotion: detailEmotion)
                }
            }
        }
    }
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if emotionViewModel.selectedEmotionList.isEmpty {
                    dismiss()
                } else {
                    isShowAlertDelete = true
                }
            }) {
                Image(systemName: "xmark")
                    .font(.bodyRegular)
            }
            Image(systemName: "xmark")
                .font(.bodyRegular)
                .foregroundColor(.clear)
                .padding(.trailing, 18)
            Spacer()
            Text(Record.emotion.writingMainText)
                .font(.bodySemibold)
            Spacer()
            HStack(spacing: 0) {
                NavigationLink {
                    SearchEmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.bodyRegular)
                        .padding(.trailing, 18)
                }
                Image(systemName: "checkmark")
                    .font(.bodyRegular)
                    .onTapGesture {
                        if emotionViewModel.selectedEmotionList == [] || emotionViewModel.selectedEmotionList.count > 6 {
                            emotionViewModel.isShowAlert = true
                        } else {
                            isShowNextView = true
                        }
                    }
                NavigationLink("", isActive: $isShowNextView) {
                    EmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel)
                }
            }
        }
        .foregroundColor(Color.gray23)
        .padding(.top, 25)
        .padding(.horizontal, 27)
    }
}

struct SelectingEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingEmotionView(isModalShow: .constant(false))
            .preferredColorScheme(.dark)
    }
}
