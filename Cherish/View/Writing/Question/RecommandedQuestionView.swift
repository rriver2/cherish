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
                dividerGray8A
                    .padding(.top, 40)
                ForEach(randomQuestion, id: \.self) { question in
                    NavigationLink {
                        QuestionView(title: question, isModalShow: $isModalShow )
                    } label: {
                        VStack(alignment: .leading){
                            Text(question)
                                .padding()
                                .multilineTextAlignment(.leading)
                                .padding(.vertical)
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
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
            }
            .navigationBarTitle("오늘의 추천 질문", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: questionType)
    }
}

struct RecommandedQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        RecommandedQuestionView(isModalShow: .constant(false))
    }
}
