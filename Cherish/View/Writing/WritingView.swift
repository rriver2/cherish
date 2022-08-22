//
//  WritingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingView: View {
    @Binding var context : String
    let date = Date().dateToString_MDY()
    
    init(context: Binding<String>) {
        self._context = context
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(date)
                .font(.miniRegular)
                .foregroundColor(Color.gray8A)
                .padding(.bottom, 8)
                .padding(.leading, 5)
            TextEditor(text: $context)
                .padding(.vertical, 23)
                .padding(.horizontal, 20)
                .foregroundColor(self.context == "내용" ? Color.grayA7 : Color.gray23)
                .onTapGesture {
                    if self.context == "내용"{
                        self.context = ""
                    }
                }
                .lineSpacing()
                .frame(height:500)
                .background(Color.grayF5)
                .cornerRadius(10)
                .font(.bodyRegular)
        }
        .onTapGesture {
            endEditing()
        }
        .tint(Color.gray23)
        .accentColor(Color.gray23)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(context: .constant("내용"))
            .preferredColorScheme(.dark)
    }
}
