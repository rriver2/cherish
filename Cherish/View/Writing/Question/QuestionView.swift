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
    @Binding var isModalShow: Bool
    @State var context = "내용"
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    
    var body: some View {
        ScrollView {
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
        .navigationBarTitle(Text(""), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                SoundView()
                Spacer()
                Button {
                    timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.question)
                    dismiss()
                    isModalShow = false
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .textInputAutocapitalization(.never)
        .tint(Color.gray23)
}
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(title: "질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다질문입니다", isModalShow: .constant(false))
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
    }
}
