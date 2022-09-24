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
    @State private var isScrollUp = false
    @State var isShowSelectedEmotion = true
    @FocusState private var isKeyboardOpen: Bool
    let tempWritingText: TempWritingText?
    
    init(isModalShow: Binding<Bool>) {
        self._isModalShow = isModalShow
        
        let key = UserDefaultKey.tempWritingEmotion.rawValue
        if let savedTempWritingText = UserDefaults.standard.object(forKey: key) as? Data,
           let loadedTempWritingText = try? JSONDecoder().decode(TempWritingText.self, from: savedTempWritingText),
           loadedTempWritingText.kind == Record.free.rawValue {
            self.tempWritingText = TempWritingText(title: loadedTempWritingText.title, context: loadedTempWritingText.context, date: loadedTempWritingText.date, kind: loadedTempWritingText.kind)
        } else {
            self.tempWritingText = nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                ScrollView(.horizontal, showsIndicators: false) {
                    SelectEmotionType()
                        .padding(.top, 50)
                }
                
                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { scrollViewProxy in
                            VStack(alignment: .leading, spacing: 0) {
                                EmotionList()
                                    .padding(.top, 13)
                            }
                            .onChange(of: isScrollUp) { newValue in
                                if isScrollUp {
                                    scrollViewProxy.scrollTo(0)
                                }
                                isScrollUp = false
                            }
                        }
                    }
                    .ignoresSafeArea()
                    VStack(spacing: 0) {
                        SelectedEmotionPopUpView(isShowSelectedEmotion: $isShowSelectedEmotion, emotionViewModel: emotionViewModel)
                    }
                }
                .ignoresSafeArea()
            }
        }
        .onAppear {
            if tempWritingText != nil {
                emotionViewModel.alertCategory = .tempWritingExistence
                emotionViewModel.isShowAlert = true
            }
        }
        .alert(isPresented: $emotionViewModel.isShowAlert) {
            emotionViewModel.showSelectingEmotionViewAlert(dismiss: dismiss, tempWritingText: tempWritingText)
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: emotionViewModel.emotionType)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
    }
}

extension SelectingEmotionView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if emotionViewModel.selectedEmotionList.isEmpty {
                    dismiss()
                } else {
                    emotionViewModel.alertCategory = .leave
                    emotionViewModel.isShowAlert = true
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
                    SearchEmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel, isShowSelectedEmotion: $isShowSelectedEmotion)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.bodyRegular)
                        .padding(.trailing, 18)
                }
                
                Image(systemName: "checkmark")
                    .font(.system(size: 16))
                    .foregroundColor(.gray23)
                    .onTapGesture {
                        if emotionViewModel.selectedEmotionList.isEmpty {
                            emotionViewModel.alertCategory = .save
                            emotionViewModel.isShowAlert = true
                        } else {
                            emotionViewModel.isShowWritingView = true
                        }
                    }
                NavigationLink("", isActive: $emotionViewModel.isShowWritingView) {
                    EmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel)
                }
            }
        }
        .foregroundColor(Color.gray23)
        .padding(.top, 25)
        .paddingHorizontal()
    }
    @ViewBuilder
    private func SelectEmotionType() -> some View {
        ZStack(alignment: .bottom) {
            divider(colorScheme)
            HStack(alignment: .top, spacing: 0) {
                let emotionList = EmotionCategory.allCases
                ForEach(emotionList.indices, id: \.self) { index in
                    let emotion = emotionList[index]
                    Button(action: {
                        emotionViewModel.emotionType = emotion
                        isScrollUp = true
                    }) {
                        if(emotionViewModel.emotionType != emotion){
                            Text(emotion.string)
                                .font(.bodyRegular)
                                .foregroundColor(Color.grayA7)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                                .overlay(alignment: .bottom) {
                                    dividerThickClear
                                }
                        } else {
                            Text(emotion.string)
                                .font(.bodySemibold)
                                .foregroundColor(Color.gray23)
                                .padding(.horizontal, 15)
                                .padding(.bottom, 10)
                                .overlay(alignment: .bottom) {
                                    dividerThick4
                                }
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
                            .foregroundColor(Color.gray23)
                        if isSelected {
                            Image(systemName: "xmark")
                                .font(.subheadline)
                                .foregroundColor(Color.gray8A)
                                .padding(.leading, 7)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(isSelected ? Color.grayE8 : .clear)
                    .cornerRadius(15)
                    .padding(.top, 18)
                    .padding(.leading, 27)
                    .id(index)
                    Spacer()
                }
                .padding(.bottom, index == emotionList.count - 1 ? 30 : 0 )
                .contentShape(Rectangle())
                .onTapGesture {
                    emotionViewModel.tabEmotion(emotion: detailEmotion)
                }
            }
        }
    }
}

struct SelectingEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingEmotionView(isModalShow: .constant(false))
//                    .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
