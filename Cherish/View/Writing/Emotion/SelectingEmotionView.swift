//
//  SelectingEmotionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct SelectingEmotionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @State private var selectedEmotion: [String] = []
    @State private var searchText = ""
    @State private var searchedEmotion: [String] = []
    @State private var isShowAlert = false
    
    @FocusState private var isKeyboardOpen: Bool
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                SearchBar()
                ScrollView {
                    if searchText == "" {
                        EmotionGroups()
                    } else {
                        SearchEmtionGroups()
                    }
                }
                .navigationBarTitle(Record.emotion.writingMainText(), displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if selectedEmotion == [] {
                            Image(systemName: "checkmark")
                                .onTapGesture {
                                    isShowAlert = true
                                }
                        } else {
                            NavigationLink {
                                
                                EmotionView(emotionList: selectedEmotion, isModalShow: $isModalShow)
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .alert("감정을 한 개 이상 선택해주세요", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
        }
        .accentColor(.defaultText)
        .tint(.defaultText)
    }
    
    func tabEmotion(emotion: String) {
        if let index = selectedEmotion.firstIndex(of: emotion) {
            selectedEmotion.remove(at: index)
        } else {
            selectedEmotion.append(emotion)
        }
    }
}

extension SelectingEmotionView {
    @ViewBuilder
    private func SearchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("감정 검색", text: $searchText)
                .onChange(of: searchText) { newValue in
                    let detailAllEmotionList = EmotionData.allList
                    searchedEmotion = detailAllEmotionList.filter {$0.contains(searchText)}
                    print(searchText, "searchText")
                }
                .focused($isKeyboardOpen)
            if searchText != "" {
                Button(action: {
                    searchText = ""
                    isKeyboardOpen = false
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                        .background(Color(hex: "F5F5F5"))
                }
            }
        }
        .padding(10)
        .background(Color(hex: "F5F5F5"))
        .cornerRadius(5)
        .padding(.vertical, 25)
    }
    @ViewBuilder
    private func EmotionGroups() -> some View {
        let emotionList = EmotionCategory.allCases
        ForEach(emotionList.indices, id: \.self) { index in
            let emotion = emotionList[index]
            VStack(alignment: .leading, spacing: 0) {
                Text(emotion.emotionText())
                    .font(.semiText)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(emotion.emotionColor())
                    .cornerRadius(15)
                    .padding(.vertical, 20)
                LazyVGrid(columns: columns, spacing: 0) {
                    let detailEmotionList = EmotionData.list[emotion]!
                    ForEach(detailEmotionList.indices, id: \.self) { index in
                        let detailEmotion = detailEmotionList[index]
                        HStack {
                            let isSelected = selectedEmotion.contains(detailEmotion)
                            Text(detailEmotion)
                                .font(isSelected ? .semiText : .mainText)
                                .padding(.horizontal, 3)
                                .background(isSelected ? emotion.emotionColor().opacity(0.4) : .white)
                                .padding(.bottom, 15)
                                .padding(.leading, 20)
                                .onTapGesture {
                                    tabEmotion(emotion: detailEmotion)
                                }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func SearchEmtionGroups() -> some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(searchedEmotion.indices, id: \.self) { index in
                let emotion = searchedEmotion[index]
                HStack {
                    let isSelected = selectedEmotion.contains(emotion)
                    let emotionCatagory = EmotionData.findEmotionCategory(emotion: emotion)
                    Text(emotion)
                        .font(isSelected ? .semiText : .mainText)
                        .padding(.horizontal, 4)
                        .background(isSelected ? emotionCatagory.emotionColor().opacity(0.4) : .white)
                        .padding(.horizontal, 3)
                        .padding(.bottom, 15)
                        .padding(.leading, 20)
                        .onTapGesture {
                            print(emotion)
                            tabEmotion(emotion: emotion)
                        }
                    Spacer()
                }
            }
        }
    }
}

struct SelectingEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingEmotionView(isModalShow: .constant(false))
    }
}
