//
//  TimelineView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct TimelineView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State var selectedRecord: RecordEntity?
    @State var isShowAlert = false
    
    var body: some View {
        if timeLineViewModel.recordsEntity.isEmpty {
            VStack(spacing: 0) {
                Title()
                Spacer()
                Text("새로운 기록을 남겨보세요")
                    .font(.miniRegular)
                    .foregroundColor(.gray8A)
                Spacer()
            }
        } else {
            ScrollView(showsIndicators : false) {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: Title().background(Color.white)) {
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
                                        .padding(.top, 26)
                                }
                                RecordBoxesView(record: record)
                            }
                        }
                        .padding(.horizontal, 27)
                    }
                    .fullScreenCover(item: $selectedRecord) { record in
                        if let selectedRecord = record,
                           let title = selectedRecord.title,
                           let context = selectedRecord.context,
                           let date = selectedRecord.date,
                        let recordMode = Record.getCatagory(record: selectedRecord.kind ?? "") {
                            WritingEditView(title: title, date: date, context: context, recordMode: recordMode)
                        }
                    }
                }
            }
            .clipped()
        }
    }
}


extension TimelineView {
    @ViewBuilder
    private func Title() -> some View {
        HStack(spacing: 0) {
            Text(TabbarCategory.timeline.rawValue)
                .foregroundColor(Color.gray23)
                .padding(.leading, 3)
            Spacer()
            SoundView()
        }
        .frame(height: 20)
        .padding(.horizontal, 27)
        .padding(.bottom, 49)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
        .background(colorScheme == .light ? .white: .black)
    }
    @ViewBuilder
    private func Date(date: String) -> some View {
        Text(date)
            .font(.miniSemibold)
            .foregroundColor(Color.grayA7)
            .padding(.leading, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 24)
    }
    @ViewBuilder
    private func RecordBoxesView(record: RecordEntity) -> some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 0) {
                let recordKind = Record.getCatagory(record: record.kind ?? "")
                Circle()
                    .foregroundColor(recordKind.color)
                    .frame(width: 32, height: 32)
                    .padding(.bottom, 9)
                Text(record.date?.dateToString_DW() ?? "")
                    .font(.timelineDate)
                    .foregroundColor(Color.grayA7)
            }
            .padding(.trailing, 16)
            VStack(spacing: 0) {
                if record.title != "" {
                    Text(record.title ?? "")
                        .font(.timelineSemibold)
                        .foregroundColor(.gray23)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                        .lineSpacing()
                        .lineLimit(1)
                }
                Text(record.context ?? "")
                    .font(.timelineRegular)
                    .foregroundColor(.gray23)
                    .lineSpacing()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxHeight: 135)
        .padding(15)
        .background(Color.grayF5)
        .cornerRadius(10)
        .padding(.bottom, 18)
        .onTapGesture {
            self.selectedRecord = record
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
        //            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
