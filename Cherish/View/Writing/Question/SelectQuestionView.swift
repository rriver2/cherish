//
//  SelectQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct SelectQuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var questionType: Question = .life
    @Binding var isModalShow: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SelectQuestionType()
                    .padding(.top, 20)
                ScrollView(showsIndicators: true){
                    QuestionList()
                }
                Spacer()
            }
            .navigationBarTitle(Record.question.writingMainText, displayMode: .inline)
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
        .accentColor(.defaultText)
        .tint(.defaultText)
        .animation(Animation.easeInOut(duration: 0.4), value: questionType)
    }
}

extension SelectQuestionView {
    @ViewBuilder
    private func SelectQuestionType() -> some View {
        ZStack(alignment: .bottom){
            HStack(alignment: .top){
                let questionTypes = Question.allCases
                ForEach(questionTypes.indices, id: \.self) { index in
                    let type = questionTypes[index]
                    Button(action: {
                        questionType = type
                    }) {
                        if(questionType != type){
                            Text(type.string)
                                .frame(width: UIScreen.main.bounds.width / CGFloat(questionTypes.count) - 20)
                        }else{
                            VStack{
                                Text(type.string)
                                    .fontWeight(.bold)
                                Rectangle().frame(height: 2.5)
                                    .foregroundColor(Color.darkGreen)
                            }
                            .frame(width: UIScreen.main.bounds.width / CGFloat(questionTypes.count) - 20)
                        }
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal, 20)
    }
    @ViewBuilder
    private func QuestionList() -> some View {
        if let questionList = QuestionData.list[questionType] {
            ForEach(questionList.indices, id : \.self){ index in
                let question = questionList[index]
                NavigationLink {
                    QuestionView(title: question, isModalShow: $isModalShow )
                } label: {
                    VStack(alignment: .leading){
                        Text(question)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .padding(.vertical)
                        Divider()
                    }
                }
            }
        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(isModalShow: .constant(false))
    }
}
