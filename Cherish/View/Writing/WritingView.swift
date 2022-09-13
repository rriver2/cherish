//
//  WritingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingView: View {
    @Binding var context : String
    @FocusState var isTextFieldsFocused: Bool
    @State var date: Date
    let contextPlaceholder: String
    @State private var isShowCalendar = false
    
    init(context: Binding<String>, contextPlaceholder: String = "내용", date: Date = Date()) {
        self._context = context
        UITextView.appearance().backgroundColor = .clear
        self.contextPlaceholder = contextPlaceholder
        self._date = State(initialValue: date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationLink {
                DateView(date: date, writingDate: $date)
            } label: {
                Text(date.dateToString_MDY())
                    .font(.miniRegular)
                    .foregroundColor(Color.gray8A)
                    .padding(.bottom, 8)
                    .padding(.leading, 5)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.grayF5)
                .overlay {
                    TextEditor(text: $context)
                        .foregroundColor(self.context == contextPlaceholder ? Color.grayA7 : Color.gray23)
                        .font(.bodyRegular)
                        .focused($isTextFieldsFocused)
                        .background(Color.grayF5)
                        .lineSpacing()
                        .padding(.vertical, 23)
                        .padding(.horizontal, 20)
                        .textSelection(.disabled)
                        .onTapGesture {
                            if self.context == contextPlaceholder{
                                self.context = ""
                            }
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                            {
                                isTextFieldsFocused = true
                                if contextPlaceholder == context {
                                    self.context = ""
                                }
                            }
                        }
                }
            Spacer()
        }
        .onTapGesture {
            endEditing()
        }
        .tint(Color.gray23)
        .accentColor(Color.gray23)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear { UITextView.appearance().backgroundColor = .clear }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(context: .constant("소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다."), contextPlaceholder: "내용")
        //            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
