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
    @Binding var selectedEmotion: [String]
    @State private var searchText = ""
    @State private var searchedEmotion: [String] = []
    @State private var isShowAlert = false
    @Binding var context: String
    
    @FocusState private var isKeyboardOpen: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SearchBar()
            ScrollView {
                SearchEmtionGroups()
                    .padding(.top, 36)
            }
        }
        
        .navigationBarTitle(Record.emotion.writingMainText, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if selectedEmotion == [] {
                    Image(systemName: "checkmark")
                        .onTapGesture {
                            isShowAlert = true
                        }
                } else {
                    NavigationLink {
                        EmotionView(emotionList: $selectedEmotion, isModalShow: $isModalShow, context: $context)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .alert("감정을 한 개 이상 선택해주세요", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
        }
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.2), value: selectedEmotion)
    }
    
    func tabEmotion(emotion: String) {
        if let index = selectedEmotion.firstIndex(of: emotion) {
            selectedEmotion.remove(at: index)
        } else {
            selectedEmotion.append(emotion)
        }
    }
}

extension SearchEmotionView {
    @ViewBuilder
    private func SearchBar() -> some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.gray23)
                TextField("감정 검색", text: $searchText)
                    .onChange(of: searchText) { newValue in
                        let detailAllEmotionList = EmotionData.allList
                        searchedEmotion = detailAllEmotionList.filter {$0.contains(searchText)}
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
        .padding(.horizontal, 27)
    }
    @ViewBuilder
    private func SearchEmtionGroups() -> some View {
        ForEach(searchedEmotion.indices, id: \.self) { index in
            let emotion = searchedEmotion[index]
            VStack(alignment: .leading) {
                HStack {
                    let isSelected = selectedEmotion.contains(emotion)
                    HStack {
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
                    tabEmotion(emotion: emotion)
                }
            }
        }
    }
}

struct SearchEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmotionView(isModalShow: .constant(false), selectedEmotion: .constant([]), context: .constant("내용"))
    }
}
