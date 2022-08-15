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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(date)
                .font(.miniRegular)
                .foregroundColor(Color.gray8A)
                .padding(.bottom, 8)
            TextEditor(text: $context)
                .padding(.vertical, 23)
                .padding(.horizontal, 20)
                .colorMultiply(Color.grayF5)
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
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(context: .constant("내용"))
    }
}
