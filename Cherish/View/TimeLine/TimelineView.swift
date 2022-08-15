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
            Title()
            if timeLineViewModel.recordsEntity.isEmpty {
                VStack(spacing: 0) {
                    Date(date: Foundation.Date().dateToString_MY())
                        .padding(.top, 50)
                    Text("아직 기록한 내용이 없습니다")
                        .font(.miniRegular)
                        .foregroundColor(Color.gray8A)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.grayF5)
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(.horizontal, 27)
            } else {
                ScrollView {
                    let recordsEntity = timeLineViewModel.recordsEntity.sorted(by: {
                        if $0.date == nil || $1.date == nil {
                            return false
                        } else {
                            return $0.date! > $1.date!
                        }
                    })
                    ForEach(recordsEntity.indices, id: \.self) { index in
                        let record = recordsEntity[index]
                        
                        VStack(alignment: .leading, spacing: 0) {
                            if index == 0, let date = record.date?.dateToString_MY() {
                                Date(date: date)
                            } else if let date = record.date?.dateToString_MY(),
                                      let preDate = recordsEntity[index - 1].date?.dateToString_MY(),
                                      date != preDate
                            {
                                Date(date: date)
                            }
                            RecordBoxesView(record: record)
                        }
                    }
                    .padding(.top, 50)
                }
                .padding(.horizontal, 27)
            }
        }
    }
}


extension TimelineView {
    @ViewBuilder
    private func Title() -> some View {
        HStack(spacing: 0) {
            Text("나의 기록")
                .font(.bigTitle)
                .foregroundColor(Color.gray23)
            Spacer()
            SoundView()
        }
        .font(.bigTitle)
        .padding(.top, 26)
        .padding(.horizontal, 27)
    }
    @ViewBuilder
    private func RecordBoxesView(record: RecordEntity) -> some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 0) {
                let recordKind = Record.getCatagory(record: record.kind ?? "")
                Circle()
                    .foregroundColor(recordKind.color)
                    .frame(width: 32, height: 32)
                Text(record.date?.dateToString_DW() ?? "")
                    .font(.timelineDate)
                    .foregroundColor(Color.grayA7)
            }
            .padding(.trailing, 16)
            VStack(alignment: .leading, spacing: 0) {
                if record.title != "" {
                    Text(record.title ?? "")
                        .font(.miniSemibold)
                        .foregroundColor(.gray23)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                        .lineSpacing()
                }
                Text(record.context ?? "")
                    .font(.miniRegular)
                    .foregroundColor(.gray23)
                    .lineSpacing()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color.grayF5)
        .cornerRadius(10)
        .padding(.bottom, 26)
    }
    @ViewBuilder
    private func Date(date: String) -> some View {
        HStack(spacing: 0) {
            Text(date)
                .font(.bodySemibold)
                .foregroundColor(Color.grayA7)
            Spacer()
        }
        .padding(.bottom, 24)
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
            .environmentObject(SoundViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
