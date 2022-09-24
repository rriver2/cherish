//
//  QuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var questionViewModel: QuestionViewModel
    @Binding var isModalShow: Bool
    @State private var alertCategory: AlertCategory = .leave
    @State var isShowAlert = false
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    @Binding var isEditMode: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            titleView(questionViewModel.title)
            WritingView(date: $questionViewModel.date, context: $questionViewModel.context, isEditMode: isEditMode)
                .padding(.top, 12)
        }
        .paddingHorizontal()
        .alert(isPresented: $isShowAlert) {
            #warning("손 슬라이드로 삭제될 때도 임시저장 문구 띄우기...")
            switch alertCategory {
                case .leave:
                    let leaveButton = Alert.Button.cancel(Text("아니오")) {
                        let key = UserDefaultKey.tempWritingQuestion.rawValue
                        UserDefaults.standard.removeObject(forKey: key)
                        dismiss()
                        isModalShow = false
                    }
                    return Alert(title: Text("임시저장하시겠습니까?"), primaryButton: .destructive(Text("네"), action: {
                        questionViewModel.initTempWritingQuestion()
                        questionViewModel.context = "내용"
                        isEditMode = false
                        dismiss()
                        isModalShow = false
                    }), secondaryButton: leaveButton)
                case .save:
                    return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                    .font(.bodyRegular)
                Spacer()
                Button {
                    if questionViewModel.context == "내용" || questionViewModel.context == "" {
                        alertCategory = .save
                        isShowAlert = true
                    } else {
                        timeLineViewModel.addRecord(date: questionViewModel.date, title: questionViewModel.title, context: questionViewModel.context, kind: Record.question)
                        addWritingPopupViewModel.isShowAddWritingPopup = true
                        addWritingPopupViewModel.writingCategory = .question
                        dismiss()
                        isModalShow = false
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                        .foregroundColor(.gray23)
                }
            }
        }
        .textInputAutocapitalization(.never)
        .tint(Color.gray23)
        .onDisappear {
            questionViewModel.context = "내용"
            isEditMode = false
        }
    }
}

extension QuestionView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if questionViewModel.context == "내용" || questionViewModel.context == "" {
                    dismiss()
                } else {
                    alertCategory = .leave
                    isShowAlert = true
                }
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
            Image(systemName: "chevron.left")
                .foregroundColor(.clear)
                .font(.bodyRegular)
        }
        .padding(.top, 25)
        .padding(.bottom, 28)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questionViewModel: QuestionViewModel(), isModalShow: .constant(false), isEditMode: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
            .environmentObject(AddWritingPopupViewModel())
    }
}
