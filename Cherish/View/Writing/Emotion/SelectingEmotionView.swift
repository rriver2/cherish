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
    @State private var isShowAlertDelete = false
    @State var context = "내용"
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
                ScrollView(showsIndicators: false){
                    EmotionList()
                }
                .padding(.top, 25)
            }
        }
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                dismiss()
            }), secondaryButton: .cancel(Text("취소")))
        }
        .alert(selectedEmotion == [] ? "감정을 한 개 이상 선택해주세요" : "6개 이하로 선택해주세요", isPresented: $isShowAlert) {
            Button("OK", role: .cancel) { }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.translation.height > 100) {
                #warning("수정해야 함..")
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
            HStack(alignment: .top, spacing: 0) {
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
                HStack(spacing: 0) {
                    let isSelected = selectedEmotion.contains(detailEmotion)
                    HStack(spacing: 0) {
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
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if selectedEmotion.isEmpty {
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
                    SearchEmotionView(isModalShow: $isModalShow, selectedEmotion: $selectedEmotion, context: $context)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.bodyRegular)
                        .padding(.trailing, 18)
                }
                Image(systemName: "checkmark")
                    .font(.bodyRegular)
                    .onTapGesture {
                        if selectedEmotion == [] || selectedEmotion.count >= 6 {
                            isShowAlert = true
                        } else {
                            isShowNextView = true
                        }
                    }
                NavigationLink("", isActive: $isShowNextView) {
                    EmotionView(emotionList: $selectedEmotion, isModalShow: $isModalShow, context: $context)
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
    }
}
