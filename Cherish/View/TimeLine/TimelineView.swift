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
            HStack(spacing: 0) {
                Text("나의 기록")
                    .font(.bigTitle)
                    .foregroundColor(Color.gray23)
                Spacer()
                SoundView()
            }
            .font(.bigTitle)
            .padding(.bottom, 30)
            .padding(.top, 20)
                .padding(.horizontal, 20)
            ScrollView {
                if timeLineViewModel.recordsEntity.isEmpty {
                    Text("아직 기록한 내용이 없습니다")
                        .font(.bigTitle)
                        .foregroundColor(Color.gray23)
                } else {
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
                                HStack(spacing: 0) {
                                    Text(date)
                                        .font(.bodySemibold)
                                        .foregroundColor(Color.grayA7)
                                        .padding(.vertical, 15)
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                            } else if let date = record.date?.dateToString_MY(),
                                      let preDate = recordsEntity[index - 1].date?.dateToString_MY(),
                                      date != preDate
                            {
                                HStack(spacing: 0) {
                                    Text(date)
                                        .font(.bodySemibold)
                                        .foregroundColor(Color.grayA7)
                                        .padding(.vertical, 15)
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                            }
                            RecordBoxesView(record: record)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}


extension TimelineView {
    @ViewBuilder
    private func RecordBoxesView(record: RecordEntity) -> some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 5) {
                let recordKind = Record.getCatagory(record: record.kind ?? "")
                Circle()
                    .foregroundColor(recordKind.color)
                    .frame(width: 32, height: 32)
                Text(record.date?.dateToString_DW() ?? "")
                    .font(.timelineDate)
                    .foregroundColor(Color.grayA7)
            }
            VStack(alignment: .leading, spacing: 0) {
                if record.title != "" {
                    Text(record.title ?? "")
                        .font(.miniSemibold)
                        .foregroundColor(.gray23)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                }
                Text(record.context ?? "")
                    .font(.miniRegular)
                    .foregroundColor(.gray23)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
        }
        .padding(15)
        .background(Color.grayF5)
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
            .environmentObject(SoundViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
