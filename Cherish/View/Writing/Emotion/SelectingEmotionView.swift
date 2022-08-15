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
    @State var selectedEmotion: [String] = []
    @State private var isShowAlert = false
    @State private var emotionType: EmotionCategory = EmotionCategory.allCases[0]
    @State private var isShowNextView = false
    @State var context = "내용"
    
    @FocusState private var isKeyboardOpen: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    SelectEmotionType()
                        .padding(.top, 50)
                }
                ScrollView(showsIndicators: false){
                    EmotionList()
                }
                .padding(.top, 25)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 0) {
                            NavigationLink {
                                SearchEmotionView(isModalShow: $isModalShow, selectedEmotion: $selectedEmotion, context: $context)
                                
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .padding(.trailing, 18)
                            }
                            Image(systemName: "checkmark")
                                .onTapGesture {
                                    if selectedEmotion == [] || selectedEmotion.count >= 6 {
                                        isShowAlert = true
                                    } else {
                                        isShowNextView = true
                                    }
                                }
                            NavigationLink("", isActive: $isShowNextView) {          EmotionView(emotionList: $selectedEmotion, isModalShow: $isModalShow, context: $context)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Record.emotion.writingMainText, displayMode: .inline)
        }
        .alert(selectedEmotion == [] ? "감정을 한 개 이상 선택해주세요" : "6개 이하로 선택해주세요", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: emotionType)
        .animation(Animation.easeInOut(duration: 0.2), value: selectedEmotion)
    }
    
    private func tabEmotion(emotion: String) {
        if let index = selectedEmotion.firstIndex(of: emotion) {
            selectedEmotion.remove(at: index)
        } else {
            selectedEmotion.append(emotion)
        }
    }
}

extension SelectingEmotionView {
    @ViewBuilder
    private func SelectEmotionType() -> some View {
        ZStack(alignment: .bottom){
            HStack(alignment: .top){
                let emotionList = EmotionCategory.allCases
                ForEach(emotionList.indices, id: \.self) { index in
                    let emotion = emotionList[index]
                    Button(action: {
                        emotionType = emotion
                    }) {
                        if(emotionType != emotion){
                            Text(emotion.string)
                                .font(.bodyRegular)
                                .foregroundColor(Color.grayA7)
                                .frame(width: UIScreen.main.bounds.width / 4.2 - 20)
                        } else {
                            VStack{
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
            dividerGray8A
        }
    }
    @ViewBuilder
    private func EmotionList() -> some View {
        if let emotionList = EmotionData.list[emotionType] {
            ForEach(emotionList.indices, id : \.self){ index in
                let detailEmotion = emotionList[index]
                HStack {
                    let isSelected = selectedEmotion.contains(detailEmotion)
                    HStack {
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
                    .padding(.bottom, 24)
                    .padding(.leading, 27)
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

struct SelectingEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingEmotionView(isModalShow: .constant(false))
    }
}
