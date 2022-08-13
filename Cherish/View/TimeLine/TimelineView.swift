//
//  TimelineView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct TimelineView: View {
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    
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
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                RecordBoxView()
            }
        }
        .background(Color.backgroundGreen)
    }
}


extension TimelineView {
    @ViewBuilder
    private func RecordBoxView() -> some View {
        ForEach(timeLineViewModel.recordsEntity) { record in
            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 5) {
                    let recordKind = Record.getCatagory(record: record.kind ?? "")
                    Image(recordKind.imageName)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(5)
                        .frame(width: 30, height: 50)
                    Text(record.date?.dateToString() ?? "")
                        .font(.miniText)
                        .foregroundColor(.dateText)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(record.title ?? "dd")
                        .font(.semiText)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.darkGreen)
                        .padding(.top, 10)
                        .padding(.bottom, 7)
                    Text(record.context ?? "dd")
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
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
            .environmentObject(SoundViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
