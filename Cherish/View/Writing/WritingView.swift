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
            VStack(alignment: .leading, spacing: 10) {
                Text(date)
                    .font(.miniText)
                    .foregroundColor(Color.gray8A)
                    .padding(.leading, 10)
                TextEditor(text: $context)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
                    .colorMultiply(Color.grayF5)
                    .foregroundColor(self.context == "내용" ? .gray : Color.gray23)
                    .onTapGesture {
                        if self.context == "내용"{
                            self.context = ""
                        }
                    }
                    .lineSpacing(10)
                    .frame(height:500)
                    .background(Color.grayF5)
                    .cornerRadius(10)
                    .font(.mainText)
            }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(context: .constant("내용"))
    }
}
