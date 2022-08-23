//
//  RecommandedQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/15.
//

import SwiftUI

struct RecommandedQuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var questionType: Question = .life
    @Binding var isModalShow: Bool
    let randomQuestion = QuestionData.randomQuestion(amount: 3)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                dividerThickGrayE8
                    .padding(.top, 40)
                ForEach(randomQuestion, id: \.self) { question in
                    NavigationLink {
                        QuestionView(title: question, isModalShow: $isModalShow )
                    } label: {
                        VStack(alignment: .leading, spacing: 0){
                            Text(question)
                                .padding(.vertical, 25)
                                .padding(.horizontal, 27)
                                .multilineTextAlignment(.leading)
                                .lineSpacing()
                                .font(.bodyRegular)
                                .foregroundColor(.gray23)
                            dividerGrayE8
                        }
                    }
                }
                NavigationLink {
                    SelectQuestionView(isModalShow: $isModalShow)
                } label: {
                    Text("다른 질문 더보기")
                        .font(.miniRegular)
                        .foregroundColor(Color.grayA7)
                        .padding(.top, 33)
                        .padding(.trailing, 27)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
            }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: questionType)
    }
}

extension RecommandedQuestionView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
            }
            Spacer()
            Text("오늘의 추천 질문")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Image(systemName: "xmark")
                .font(.bodyRegular)
                .foregroundColor(.clear)
        }
        .padding(.top, 25)
        .padding(.horizontal, 27)
    }
}

struct RecommandedQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        RecommandedQuestionView(isModalShow: .constant(false))
            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
