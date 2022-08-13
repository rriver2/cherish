//
//  WritingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingView: View {
    @Binding var context : String
    let date = Date().dateToString()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(date)
                    .font(.miniText)
                    .foregroundColor(.dateText)
                    .padding(.leading, 10)
                TextEditor(text: $context)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
                    .colorMultiply(Color.backgroundGreen)
                    .foregroundColor(self.context == "내용" ? .gray : .defaultText)
                    .onTapGesture {
                        if self.context == "내용"{
                            self.context = ""
                        }
                    }
                    .lineSpacing(10)
                    .frame(height:500)
                    .background(Color.backgroundGreen)
                    .cornerRadius(10)
                    .font(.mainText)
            }
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView(context: .constant("내용"))
    }
}
