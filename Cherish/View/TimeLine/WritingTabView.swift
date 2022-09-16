//
//  WritingTabView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/16.
//

import SwiftUI

struct WritingTabView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State var writingIndex: Int
    
    var body: some View {
        TabView(selection: $writingIndex) {
            let array = Array(0..<timeLineViewModel.recordsEntity.count)
            ForEach(array, id: \.self) { index in
                let selectedRecord = timeLineViewModel.recordsEntity[index]
                WritingEditView(title: selectedRecord.title ?? "tempTitle", date: selectedRecord.date ?? Date(), context: selectedRecord.context ?? "tempContent", recordMode: Record.getCatagory(record: selectedRecord.kind ?? "") )
                    .tag(index)
                
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct WritingTabView_Previews: PreviewProvider {
    static var previews: some View {
        WritingTabView(writingIndex: 0)
            .environmentObject(DarkModeViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
