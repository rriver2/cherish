//
//  SearchEmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/14.
//

import SwiftUI

struct SearchEmotionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @ObservedObject var emotionViewModel: EmotionViewModel
    @State private var isShowAlert = false
    @GestureState private var dragOffset = CGSize.zero
    @FocusState private var isKeyboardOpen: Bool
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            SearchBar()
            ScrollView(showsIndicators : false) {
                SearchEmtionGroups()
                    .padding(.top, 36)
            }
        }
        .alert("감정을 한 개 이상 선택해주세요", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
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
                TextField("감정 검색", text: $searchText)
                    .onChange(of: searchText) { newValue in
                        if newValue == "" {
                            emotionViewModel.searchedEmotionList = emotionViewModel.userDefaultEmotionList
                        } else {
                            let detailAllEmotionList = EmotionData.allList
                            emotionViewModel.searchedEmotionList = detailAllEmotionList.filter { $0.contains(searchText) }
                        }
                    }
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
        .padding(.horizontal, 27)
    }
    @ViewBuilder
    private func SearchEmtionGroups() -> some View {
        ForEach(emotionViewModel.searchedEmotionList.indices, id: \.self) { index in
            let emotion = emotionViewModel.searchedEmotionList[index]
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    let isSelected = emotionViewModel.selectedEmotionList.contains(emotion)
                    HStack(spacing: 0) {
                        Text(emotion)
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
                    .padding(.bottom, 24)
                    .padding(.leading, 27)
                    Spacer()
                }
                .background(.white)
                .onTapGesture {
                    emotionViewModel.tabEmotion(emotion: emotion)
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
                    .font(.bodyRegular)
            }
            Spacer()
            Text(Record.emotion.writingMainText)
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            if emotionViewModel.selectedEmotionList == [] {
                Image(systemName: "checkmark")
                    .onTapGesture {
                        isShowAlert = true
                    }
            } else {
                NavigationLink {
                    EmotionView(isModalShow: $isModalShow, emotionViewModel: emotionViewModel)
                } label: {
                    Image(systemName: "checkmark")
                        .font(.bodyRegular)
                }
            }
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .padding(.horizontal, 27)
    }
}

struct SearchEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmotionView(isModalShow: .constant(false), emotionViewModel: EmotionViewModel())
    }
}
