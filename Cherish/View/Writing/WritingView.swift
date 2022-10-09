//
//  WritingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingView: View {
    @Binding var context : String {
        didSet {
            isContextChanged = true
        }
    }
    @FocusState var isTextEditorFocused: Bool
    @Binding var date: Date
    let contextPlaceholder: String
    @State private var isShowCalendar = false
    let isKeyBoardOn: Bool
    @State private var isContextChanged: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    init(date: Binding<Date>, context: Binding<String>, contextPlaceholder: String = "내용", isKeyBoardOn: Bool = true, isEditMode: Bool = false) {
        self._date = date
        self._context = context
        self.contextPlaceholder = contextPlaceholder
        self.isKeyBoardOn = isKeyBoardOn
        if isEditMode {
            self._isContextChanged = State(initialValue: true)
        } else {
            self._isContextChanged = State(initialValue: false)
        }
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
                    if #available(iOS 16.0, *) {
                        TextEditor(text: $context)
                            .foregroundColor(isContextChanged ? Color.gray23 : Color.grayA7)
                            .font(.bodyRegular)
                            .focused($isTextEditorFocused)
                            .background(Color.grayF5)
                            .lineSpacing()
                            .padding(.vertical, 23)
                            .padding(.horizontal, 20)
                            .textSelection(.disabled)
                            .onTapGesture {
                                if self.context == contextPlaceholder {
                                    self.context = ""
                                }
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                                {
                                    if isKeyBoardOn {
                                        isTextEditorFocused = true
                                        if contextPlaceholder == context {
                                            self.context = ""
                                        }
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                    } else {
                        TextEditor(text: $context)
                            .foregroundColor(isContextChanged ? Color.gray23 : Color.grayA7)
                            .font(.bodyRegular)
                            .focused($isTextEditorFocused)
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                                {
                                    if isKeyBoardOn {
                                        isTextEditorFocused = true
                                        if contextPlaceholder == context {
                                            self.context = ""
                                        }
                                    }
                                }
                            }
                    }
                }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
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
        WritingView(date: .constant(Date()), context: .constant("소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다."), contextPlaceholder: "내용")
            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
