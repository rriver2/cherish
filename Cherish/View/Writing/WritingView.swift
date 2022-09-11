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
    @State var date: Date = Date()
    let contextPlaceholder: String
    @State private var isShowCalendar = false
    
    init(context: Binding<String>, contextPlaceholder: String = "내용") {
        self._context = context
        UITextView.appearance().backgroundColor = .clear
        self.contextPlaceholder = contextPlaceholder
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
        WritingView(context: .constant("내용"), contextPlaceholder: "내용")
        //            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
