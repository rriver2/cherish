//
//  SearchEmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/14.
//

import SwiftUI

struct SearchEmotionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @ObservedObject var emotionViewModel: EmotionViewModel
    @State private var isShowAlert = false
    @GestureState private var dragOffset = CGSize.zero
    @FocusState private var isKeyboardOpen: Bool
    @State private var searchText: String = ""
    @Binding var isShowSelectedEmotion: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            SearchBar()
            
            if searchText == "" {
                SearchingEmtionBar()
                ZStack {
                    EmtionGroups(emotionList: emotionViewModel.userDefaultEmotionList, addEmotionToDevice: false)
                    VStack {
                        Spacer()
                        SelectedEmotionPopUpView(isShowSelectedEmotion: $isShowSelectedEmotion, emotionViewModel: emotionViewModel)
                    }
                    .ignoresSafeArea()
                }
            } else {
                ZStack {
                    EmtionGroups(emotionList: emotionViewModel.searchedEmotionList, addEmotionToDevice: true)
                    VStack {
                        Spacer()
                        SelectedEmotionPopUpView(isShowSelectedEmotion: $isShowSelectedEmotion, emotionViewModel: emotionViewModel)
                    }
                    .ignoresSafeArea()
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                emotionViewModel.searchedEmotionList = emotionViewModel.userDefaultEmotionList
            } else {
                let detailAllEmotionList = EmotionData.allList
                emotionViewModel.searchedEmotionList = detailAllEmotionList.filter { $0.contains(searchText) }
            }
        }
        .alert("감정을 한 개 이상 선택해주세요", isPresented: $isShowAlert) {
            Button("확인", role: .cancel) { }
        }
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                dismiss()
            }
        })
        .onAppear {
            emotionViewModel.searchedEmotionList = emotionViewModel.userDefaultEmotionList
        }
        .animation(Animation.easeInOut(duration: 0.2), value: searchText)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
    }
}

extension SearchEmotionView {
    @ViewBuilder
    private func SearchBar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.bodyRegular)
                    .foregroundColor(Color.gray23)
                    .padding(.trailing, 7)
                TextField("감정 검색", text: $searchText)
                    .submitLabel(.done)
                    .font(.bodyRegularSmall)
                    .focused($isKeyboardOpen)
                    .foregroundColor(.gray23)
                if searchText != "" {
                    Button(action: {
                        searchText = ""
                        isKeyboardOpen = false
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color.gray23.opacity(0.5))
                            .padding(.trailing, 15)
                            .frame(width: 18, height: 18)
                            .background(Color.grayF5)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 9)
            .background(Color.grayF5)
            .cornerRadius(5)
        }
        .padding(.top, 34)
        .paddingHorizontal()
    }
    @ViewBuilder
    private func EmtionGroups(emotionList: [String], addEmotionToDevice: Bool) -> some View {
        ScrollView(showsIndicators : false) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(emotionList.indices, id: \.self) { index in
                    let emotion = emotionList[index]
                    HStack(spacing: 0) {
                        let isSelected = emotionViewModel.selectedEmotionList.contains(emotion)
                        HStack(spacing: 0) {
                            Text(emotion)
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
                        .padding(.bottom, 24)
                        .padding(.leading, 26)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        emotionViewModel.tabEmotion(emotion: emotion)
                        if addEmotionToDevice {
                            emotionViewModel.addEmotionToDevice(emotion: emotion)
                        }
                    }
                }
            }
        }
        .padding(.top, 36)
    }
    @ViewBuilder
    private func SearchingEmtionBar() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("최근 검색어")
                    .font(.miniSemibold)
                    .foregroundColor(.gray8A)
                Spacer()
                if !emotionViewModel.userDefaultEmotionList.isEmpty {
                    Text("비우기")
                        .font(.miniRegular)
                        .foregroundColor(.gray8A)
                        .onTapGesture {
                            emotionViewModel.deleteEmotionsOnDevice()
                        }
                }
            }
            .padding(.horizontal, 38)
            .padding(.top, 20)
        }
    }
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyRegular)
            }
            Spacer()
            Text(Record.emotion.writingMainText)
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            if emotionViewModel.selectedEmotionList == [] {
                Image(systemName: "checkmark")
                    .font(.system(size: 16))
                    .foregroundColor(.gray23)
                    .onTapGesture {
                        isShowAlert = true
                    }
            } else {
                NavigationLink {
                    EmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel)
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                        .foregroundColor(.gray23)
                }
            }
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .paddingHorizontal()
    }
}

struct SearchEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmotionView(isModalShow: .constant(false), emotionViewModel: EmotionViewModel(), isShowSelectedEmotion: .constant(true))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
