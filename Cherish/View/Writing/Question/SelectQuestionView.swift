//
//  SelectQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct SelectQuestionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var questionType: Question = .life
    @Binding var isModalShow: Bool
    @GestureState private var dragOffset = CGSize.zero
    @State private var isScrollUp = false
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            SelectQuestionType()
                .padding(.top, 40)
            ScrollView(showsIndicators: false) {
                ScrollViewReader { scrollViewProxy in
                    VStack(alignment: .leading, spacing: 0) {
                        QuestionList()
                    }
                    .onChange(of: isScrollUp) { newValue in
                        if isScrollUp {
                            scrollViewProxy.scrollTo(0)
                        }
                        isScrollUp = false
                    }
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                dismiss()
            }
        })
        .animation(Animation.easeInOut(duration: 0.4), value: questionType)
    }
}

extension SelectQuestionView {
    @ViewBuilder
    private func SelectQuestionType() -> some View {
        ZStack(alignment: .bottom){
            dividerThick2(colorScheme)
            HStack(alignment: .top, spacing: 0) {
                let questionTypes = Question.allCases
                ForEach(questionTypes.indices, id: \.self) { index in
                    let type = questionTypes[index]
                    Button(action: {
                        questionType = type
                        isScrollUp = true
                    }) {
                        if(questionType != type){
                            Text(type.string)
                                .font(.bodyRegular)
                                .foregroundColor(Color.grayA7)
                                .frame(width: UIScreen.main.bounds.width / CGFloat(questionTypes.count) - 20)
                        }else{
                            VStack(spacing: 8) {
                                Text(type.string)
                                    .font(.bodySemibold)
                                    .foregroundColor(Color.gray23)
                                dividerThick4
                            }
                            .frame(width: UIScreen.main.bounds.width / CGFloat(questionTypes.count) - 20)
                        }
                    }
                }
            }
        }
    }
    @ViewBuilder
    private func QuestionList() -> some View {
        if let questionList = QuestionData.list[questionType] {
            ForEach(questionList.indices, id : \.self){ index in
                let question = questionList[index]
                NavigationLink {
                    QuestionView(title: question, isModalShow: $isModalShow)
                } label: {
                    VStack(alignment: .leading, spacing: 0){
                        Text(question)
                            .font(.bodyRegular)
                            .foregroundColor(Color.gray23)
                            .multilineTextAlignment(.leading)
                            .lineSpacing()
                            .padding(.vertical, 25)
                            .paddingHorizontal()
                        divider(colorScheme)
                    }
                    .id(index)
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
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
            }
            Spacer()
            Text(Record.question.writingMainText)
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            NavigationLink {
                SearchQuestionView(isModalShow: $isModalShow)
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.bodyRegular)
            }
        }
        .padding(.top, 25)
        .paddingHorizontal()
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(isModalShow: .constant(false))
            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
