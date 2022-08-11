//
//  RecordBoxView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct RecordBoxView: View {
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 5) {
                Image("Ocean")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(5)
                    .frame(width: 30, height: 50)
                Text("29 (FRI)")
                    .font(.miniText)
                    .foregroundColor(.dateText)
            }
            VStack(alignment: .leading, spacing: 0) {
                Text("단 한 가지 것에 집중하신다면 무엇을 선택하시겠습니까?")
                    .font(.semiText)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.darkGreen)
                    .padding(.top, 10)
                    .padding(.bottom, 7)
                Text("열 명의 사람 중 두세 명에게서 미움을 받는다면 문제가 없어 보인다. 그러나 그게 백 명, 천 명이 넘어가면 두렵다. 퍼센티지로는 동률이어도 숫자로 세어지는 마음이 미움이다. 살면서 대하는 사람들이 늘어나며, 어느 순간 이에 대한 선택을 하기로 했다. ‘그럼에도 불구하고 생긴 대로 살아야겠다는 것’ 말이다.")
                    .font(.mainText)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
        }
        .padding(15)
        .background(.white)
        .cornerRadius(10)
    }
}

struct RecordBoxView_Previews: PreviewProvider {
    static var previews: some View {
        RecordBoxView()
    }
}
