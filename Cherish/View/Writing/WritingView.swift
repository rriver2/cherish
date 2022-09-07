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
    let contextPlaceholder: String
    
    init(context: Binding<String>, contextPlaceholder: String = "내용") {
        self._context = context
        UITextView.appearance().backgroundColor = .clear
        self.contextPlaceholder = contextPlaceholder
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
                .onTapGesture {
                    if self.context == contextPlaceholder{
                        self.context = ""
                    }
                }
                .onChange(of: context, perform: { newValue in
                    print(self.context == contextPlaceholder)
                })
                .foregroundColor(self.context == contextPlaceholder ? Color.grayA7 : Color.gray23)
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
        WritingView(context: .constant("내용"), contextPlaceholder: "내용")
            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
