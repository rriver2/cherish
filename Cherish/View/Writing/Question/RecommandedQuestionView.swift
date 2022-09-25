//
//  RecommandedQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/15.
//

import SwiftUI

struct RecommandedQuestionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @StateObject var questionViewModel = QuestionViewModel()
    @State private var questionType: Question = .life
    @State private var isShowWritingView = false
    @Binding var isModalShow: Bool
    @State var isEditMode = false
    @State var isShowAlert: Bool
    let randomQuestion: [String]
    let tempWritingText: TempWritingText?
    
    init(isModalShow: Binding<Bool>) {
        self._isModalShow = isModalShow
        self.randomQuestion = QuestionData.randomQuestion(amount: 3)
        
        let key = UserDefaultKey.tempWritingQuestion.rawValue
        if let savedTempWritingText = UserDefaults.standard.object(forKey: key) as? Data,
           let loadedTempWritingText = try? JSONDecoder().decode(TempWritingText.self, from: savedTempWritingText),
           loadedTempWritingText.kind == Record.free.rawValue {
            self.tempWritingText = TempWritingText(title: loadedTempWritingText.title, context: loadedTempWritingText.context, date: loadedTempWritingText.date, kind: loadedTempWritingText.kind)
            self._isShowAlert = State(initialValue: true)
        } else {
            self.tempWritingText = nil
            self._isShowAlert = State(initialValue: false)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                NavigationBar()
                dividerThick2(colorScheme)
                    .padding(.top, 40)
                    ForEach(randomQuestion, id: \.self) { question in
                        VStack(alignment: .leading, spacing: 0){
                            Text(question)
                                .padding(.vertical, 25)
                                .paddingHorizontal()
                                .multilineTextAlignment(.leading)
                                .lineSpacing()
                                .font(.bodyRegular)
                                .foregroundColor(.gray23)
                                .onTapGesture {
                                    questionViewModel.title = question
                                    isShowWritingView = true
                                }
                            divider(colorScheme)
                        }
                    }
                NavigationLink {
                    SelectQuestionView(isModalShow: $isModalShow, questionViewModel: questionViewModel)
                } label: {
                    Text("다른 질문 더보기")
                        .font(.miniRegular)
                        .foregroundColor(Color.grayA7)
                        .padding(.top, 33)
                        .padding(.trailing, 27)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                NavigationLink("", isActive: $isShowWritingView) {
                    QuestionView(questionViewModel: questionViewModel, isModalShow: $isModalShow, isEditMode: $isEditMode)
                }
                Spacer()
            }
        }
        .accentColor(Color.gray23)
        .tint(Color.gray23)
        .animation(Animation.easeInOut(duration: 0.4), value: questionType)
        .alert(isPresented: $isShowAlert) {
            let newWritingButton = Alert.Button.cancel(Text("새 글 작성")) {
                let key = UserDefaultKey.tempWritingQuestion.rawValue
                UserDefaults.standard.removeObject(forKey: key)
            }
            return Alert(title: Text("작성 중인 글이 있습니다. 불러오시겠습니까?"), primaryButton: .destructive(Text("불러오기"), action: {
                if let tempWritingText = tempWritingText {
                    self.questionViewModel.title = tempWritingText.title
                    self.questionViewModel.context = tempWritingText.context
                    self.questionViewModel.date = tempWritingText.date
                    self.isShowWritingView = true
                    self.isEditMode = true
                }
            }), secondaryButton: newWritingButton)
        }
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
        .paddingHorizontal()
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
