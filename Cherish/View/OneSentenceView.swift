//
//  OneSentenceView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/08.
//

import SwiftUI

struct OneSentenceView: View {
    @Binding var oneSentence: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // TODO: 글씨 수 제한, 디자인 입히기
                TextField(oneSentence, text: $oneSentence)
                    .padding(.top, 10)
                Spacer()
            }
            .padding(.horizontal,20)
            .navigationBarTitle("나의 한 문장 수정", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                    Spacer()
                    Button {
                        // TODO: 저장 로직 추가
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .textInputAutocapitalization(.never)
        }
    }
}

struct OneSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        OneSentenceView(oneSentence: .constant("일단 뭐든 해보자"))
    }
}
