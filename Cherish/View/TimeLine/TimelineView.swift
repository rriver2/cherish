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
        .background(Color.backgroundGreen)
    }
}


extension TimelineView {
    @ViewBuilder
    private func RecordBoxesView(record: RecordEntity) -> some View {
        
        HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 5) {
                let recordKind = Record.getCatagory(record: record.kind ?? "")
                Image(recordKind.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 40)
                    .cornerRadius(5)
                Text(record.date?.dateToString_DW() ?? "")
                    .font(.miniText)
                    .foregroundColor(.dateText)
            }
            VStack(alignment: .leading, spacing: 0) {
                if record.title != "" {
                    Text(record.title ?? "")
                        .font(.semiText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.lightGreen)
                        .padding(.top, 10)
                        .padding(.bottom, 7)
                }
                Text(record.context ?? "")
                    .font(.mainText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
        }
        .padding(15)
        .background(.white)
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
