//
//  QuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct QuestionView: View {
    let title: String
    @Environment(\.dismiss) private var dismiss
    @GestureState private var dragOffset = CGSize.zero
    @Binding var isModalShow: Bool
    @State var context = "내용"
    @State private var alertCategory: AlertCategory = .leave
    @State var isShowAlert = false
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            ScrollView(showsIndicators : false) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.bodyRegular)
                    .lineSpacing()
                    .foregroundColor(Color.gray23)
                    .padding(.top, 2)
                WritingView(context: $context)
                    .padding(.top, 25)
            }
            .padding(.horizontal, 27)
        }
        .alert(isPresented: $isShowAlert) {
            switch alertCategory {
                case .leave:
                    return Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                        dismiss()
                    }), secondaryButton: .cancel(Text("머무르기")))
                case .save:
                    return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("네")))
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView(popCategory: .popUp)
                    .font(.bodyRegular)
                Spacer()
                Button {
                    if context == "내용" || context == "" {
                        alertCategory = .save
                        isShowAlert = true
                    } else {
                        timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.question)
                        addWritingPopupViewModel.isShowAddWritingPopup = true
                        addWritingPopupViewModel.writingCategory = .question
                        dismiss()
                        isModalShow = false
                    }
                } label: {
                    Image("check")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 13, height: 9)
                        .foregroundColor(.gray23)
                        .font(.bodyRegular)
                }
            }
        }
        .textInputAutocapitalization(.never)
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
//#warning("왜 context가 내용으로 인식되는 거지 ? help")
//            print(context)
//            if (value.startLocation.x < 30 && value.translation.width > 100) {
//                if context == "내용" || context == "" {
//                    dismiss()
//                } else {
//                    alertCategory = .leave
//                    isShowAlert = true
//                }
//            }
        })
    }
}

extension QuestionView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if context == "내용" || context == "" {
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
        .padding(.horizontal, 27)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(title: "질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다", isModalShow: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
            .environmentObject(AddWritingPopupViewModel())
    }
}
