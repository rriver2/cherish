//
//  WritingTabView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/16.
//

import SwiftUI

struct WritingTabView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State var writingIndex: Int
    @State var isEditMode = false
    @State var isShowAlert = false
    @State var alertCategory: AlertCategory = .remove
    
    enum AlertCategory {
        case remove
        case afterRemove
        case leave
}
    
    var body: some View {
        let selectedRecord = timeLineViewModel.recordsEntity[writingIndex]
        let title = selectedRecord.title ?? "tempTitle"
        let date = selectedRecord.date ?? Date()
        let context = selectedRecord.context ?? "tempContent"
        let recordMode = Record.getCatagory(record: selectedRecord.kind ?? "")
        VStack(spacing: 0) {
            if isEditMode {
                NavigationView {
                    WritingEditView(title: title, date: date, context: context, recordMode: recordMode, isEditMode: $isEditMode)
                }
            } else {
                VStack(spacing: 0) {
                    NavigationBar(title: recordMode.writingMainText)
                    TabView(selection: $writingIndex) {
                        let array = Array(0..<timeLineViewModel.recordsEntity.count)
                        ForEach(array, id: \.self) { index in
                            WritingPreview(title: title, date: date, context: context, recordMode: recordMode, isEditMode: $isEditMode)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
                .alert(isPresented: $isShowAlert) {
                    showAlert(date: date)
                }
            }
        }
        .animation(Animation.easeInOut(duration: 0.4), value: isEditMode)
    }
    
    private func showAlert(date: Date) -> Alert {
        switch alertCategory {
            case .remove:
                return Alert(title: Text("정말로 기록을 삭제하시겠습니까?"), message: Text("삭제 후에는 복원할 수 없습니다."), primaryButton: .destructive(Text("삭제"), action: {
                    timeLineViewModel.removeRecord(id: date)
                    dismiss()
                }), secondaryButton: .cancel(Text("취소")))
            case .afterRemove:
                // 수정해야함
                return Alert(title: Text("기록이 삭제되었습니다."), message: nil, dismissButton: .cancel(Text("확인")))
            case .leave:
                return Alert(title: Text("기록한 내용은 저장되지 않습니다."), message: Text("그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                    isEditMode = false
                }), secondaryButton: .cancel(Text("머무르기")))
        }
    }
}

extension WritingTabView {
    @ViewBuilder
    private func NavigationBar(title: String) -> some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(title)
                    .font(.bodySemibold)
                    .foregroundColor(Color.gray23)
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
                    .padding(.trailing, 18)
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Image(systemName: "square.and.pencil")
                    .font(.bodyRegular)
                    .foregroundColor(.gray23)
                    .padding(.trailing, 30)
                    .onTapGesture {
                        isEditMode = true
                    }
                Image(systemName: "trash")
                    .font(.bodyRegular)
                    .foregroundColor(.gray23)
                    .onTapGesture {
                        alertCategory = .remove
                        isShowAlert = true
                    }
            }
        }
        .padding(.top, 25)
        .padding(.bottom, 28)
        .paddingHorizontal()
    }
}

struct WritingTabView_Previews: PreviewProvider {
    static var previews: some View {
        WritingTabView(writingIndex: 0)
            .environmentObject(DarkModeViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
