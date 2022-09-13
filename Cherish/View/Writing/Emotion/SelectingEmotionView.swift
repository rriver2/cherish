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
    @State private var isScrollUp = false
    @State var isShowSelectedEmotion = true
    
    @FocusState private var isKeyboardOpen: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                ScrollView(.horizontal, showsIndicators: false) {
                    SelectEmotionType()
                        .padding(.top, 50)
                }
                
                ZStack {
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
                    VStack {
                        Spacer()
                        SelectedEmotionPopUpView(isShowSelectedEmotion: $isShowSelectedEmotion, emotionViewModel: emotionViewModel)
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .alert(isPresented: $emotionViewModel.isShowAlert) {
            emotionViewModel.showSelectingEmotionViewAlert(dismiss: dismiss)
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: emotionViewModel.emotionType)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
    }
}

extension SelectingEmotionView {
    @ViewBuilder
    private func SelectEmotionType() -> some View {
        ZStack(alignment: .bottom) {
            dividerGrayE8
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
                                    dividerThickGray8A
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
                    .id(index)
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
                
                Image("check")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 13, height: 9)
                    .font(.bodyRegular)
                    .onTapGesture {
                        if emotionViewModel.selectedEmotionList.isEmpty {
                            emotionViewModel.alertCategory = .save
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
        //            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
