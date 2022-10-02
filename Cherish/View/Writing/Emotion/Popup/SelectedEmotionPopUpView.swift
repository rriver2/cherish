//
//  SelectedEmotionPopUpView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/12.
//

import SwiftUI

struct SelectedEmotionPopUpView: View {
    @Binding var isShowSelectedEmotion: Bool
    @ObservedObject var emotionViewModel: EmotionViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State var isShowInfoView = false
    
    private let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading),
        GridItem(.flexible(), spacing: 0, alignment: .leading)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 10) {
                    Text("선택한 감정")
                        .font(.miniSemibold)
                        .foregroundColor(.gray23)
                    let colorMode = colorScheme == .light ? "LightMode" : "DarkMode"
                    Image("EmotionSelectButton\(colorMode)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 9, height: 4)
                        .rotationEffect(isShowSelectedEmotion ? .degrees(0) : .degrees(180))
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isShowSelectedEmotion.toggle()
                }
                Image(systemName: "info.circle")
                    .font(.system(size: 15))
                    .foregroundColor(.gray8A)
                    .onTapGesture {
                        isShowInfoView = true
                    }
            }
            .padding(.vertical, 24)
            .padding(.bottom, 5)
            
            if isShowSelectedEmotion {
                if emotionViewModel.selectedEmotionList.isEmpty {
                    Text("최대 6개의 감정을 선택할 수 있습니다")
                        .font(.miniRegular)
                        .foregroundColor(.gray23)
                } else {
                    LazyVGrid(columns: columns, spacing: 15) {
                        let emotionList = emotionViewModel.selectedEmotionList
                        ForEach(emotionList.indices, id : \.self){ index in
                            let detailEmotion = emotionList[index]
                            HStack(spacing: 0) {
                                let isSelected = emotionViewModel.selectedEmotionList.contains(detailEmotion)
                                HStack(spacing: 0) {
                                    Text(detailEmotion)
                                        .frame(alignment: .leading)
                                        .font(.miniRegular)
                                        .foregroundColor(Color.gray23)
                                    Spacer()
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
                                .padding(.horizontal, 5)
                            }
                            .onTapGesture {
                                emotionViewModel.tabEmotion(emotion: detailEmotion)
                            }
                        }
                    }
                }
            }
        }
        .paddingHorizontal()
        .padding(.bottom, isShowSelectedEmotion ? 50 : 0)
        .background(Color.grayF5)
        .cornerRadius(14, corners: [.topLeft, .topRight])
        .sheet(isPresented: $isShowInfoView) {
            EmotionInfoView()
        }
        .animation(Animation.easeInOut(duration: 0.3), value: isShowSelectedEmotion)
        .animation(Animation.easeInOut(duration: 0.2), value: emotionViewModel.selectedEmotionList)
    }
}

struct SelectedEmotionPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedEmotionPopUpView(isShowSelectedEmotion: .constant(true), emotionViewModel: EmotionViewModel())
    }
}
