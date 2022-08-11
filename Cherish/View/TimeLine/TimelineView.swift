//
//  TimelineView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
        VStack(spacing: 0) {
            TitleView(title: "나의 끄적임들")
                .padding(.horizontal, 20)
            ScrollView {
                HStack(spacing: 0) {
                    Text("July 2022")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    Spacer()
                }
                
                ForEach(0..<6) { _ in
                    RecordBoxView()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                }
            }
            .background(Color.backgroundGreen)
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
            .environmentObject(SoundViewModel())
    }
}
