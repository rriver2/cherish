//
//  WritingPreview.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/24.
//
import SwiftUI

struct WritingPreview: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isEditMode: Bool
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    let recordMode: Record
    let title: String
    let date: Date
    let context: String
    @State var isShowAlert = false
    
    init(title: String, date: Date, context: String, recordMode: Record, isEditMode: Binding<Bool>) {
        self.title = title
        self.date = date
        self.context = context
        self.recordMode = recordMode
        self._isEditMode = isEditMode
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FullRecordView()
            Spacer()
        }
        .paddingHorizontal()
    }
}

extension WritingPreview {
    @ViewBuilder
    private func FullRecordView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if title != "" {
                titleView(title)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(date.dateToString_MDY())
                    .font(.miniRegular)
                    .foregroundColor(Color.gray8A)
                    .padding(.bottom, 8)
                    .padding(.leading, 5)
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.grayF5)
                    .overlay(alignment: .topLeading) {
                        ScrollView {
                            Text(context)
                                .foregroundColor(Color.gray23)
                                .font(.bodyRegular)
                                .background(Color.grayF5)
                                .lineSpacing()
                                .padding(.horizontal, 10)
                        }
                        .padding(.vertical, 23)
                        .padding(.horizontal, 20)
                        .cornerRadius(10)
                    }
                Spacer()
            }
        }
    }
}

struct WritingPreview_Previews: PreviewProvider {
    static var previews: some View {
        WritingPreview(title: "단 한 가지 것에 집중한다면 무엇을 선택하고 싶나요?", date: Date(), context: "소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.", recordMode: Record.question, isEditMode: .constant(false))
            .environmentObject(SoundViewModel())
    }
}
