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
    @State var isShowAlert = false
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            ScrollView(showsIndicators : false) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.bodyRegular)
                    .lineSpacing()
                    .foregroundColor(Color.gray23)
                    .padding(.top, 30)
                WritingView(context: $context)
                    .padding(.top, 25)
            }
            .padding(.horizontal, 27)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                    .font(.bodyRegular)
                Spacer()
                Button {
                    timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.question)
                    dismiss()
                    isModalShow = false
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.gray23)
                        .font(.bodyRegular)
                }
            }
        }
        .textInputAutocapitalization(.never)
        .tint(Color.gray23)
        .alert(isPresented: $isShowAlert) {
            Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                dismiss()
            }), secondaryButton: .cancel(Text("취소")))
        }
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                if context != "내용" {
                    isShowAlert = true
                } else {
                    dismiss()
                }
            }
        })
    }
}

extension QuestionView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if context != "내용" {
                    isShowAlert = true
                } else {
                    dismiss()
                }
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
                    .padding(.top, 25)
            }
            Spacer()
        }
        .padding(.horizontal, 27)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(title: "질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다", isModalShow: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
    }
}
