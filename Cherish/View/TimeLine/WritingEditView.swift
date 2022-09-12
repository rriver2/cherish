//
//  WritingEditView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/12.
//

import SwiftUI

struct WritingEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State var title: String
    @State var date: Date
    @State var context: String
    @State var isEditMode = false
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    let recordMode: Record
    @State var isShowAlert = false
    @State var removeRecordAlertCategory: RemoveRecordAlertCategory = .confirm
    
    let originTitle: String
    let originDate: Date
    let originContext: String
    
    enum RemoveRecordAlertCategory {
        case confirm
        case after
    }
    
    init(title: String, date: Date, context: String, recordMode: Record) {
        self._title = State(initialValue: title)
        self._date = State(initialValue: date)
        self._context = State(initialValue: context)
        self.originTitle = title
        self.originDate = date
        self.originContext = context
        self.recordMode = recordMode
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                FullRecordView()
                Spacer()
            }
            .padding(.horizontal, 27)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                        .font(.bodyRegular)
                    Spacer()
                    Button {
                        timeLineViewModel.updateRecord(date: date, title: title, context: context)
                        dismiss()
                    } label: {
                        Image("check")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 13, height: 9)
                            .foregroundColor(.gray23)
                            .font(.bodyRegular)
                    }
                }
            }
            .alert(isPresented: $isShowAlert) {
                showAlert()
            }
        }
    }
    
    private func showAlert() -> Alert {
        switch removeRecordAlertCategory {
            case .confirm:
                return  Alert(title: Text("정말로 기록을 삭제하시겠습니까? 삭제하신 이후에는 복원할 수 없습니다."), primaryButton: .destructive(Text("삭제"), action: {
                    timeLineViewModel.removeRecord(id: date)
                    dismiss()
                }), secondaryButton: .cancel(Text("취소")))
            case .after:
                // 수정해야함
                return Alert(title: Text("기록이 삭제되었습니다."), message: nil, dismissButton: .cancel(Text("확인")))
        }
    }
}

extension WritingEditView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(TabbarCategory.timeline.rawValue)
                    .font(.bodySemibold)
                    .foregroundColor(Color.gray23)
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray23)
                        .font(.bodyRegular)
                        .padding(.trailing, 18)
                }
                Spacer()
                if !isEditMode {
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
                            isShowAlert = true
                        }
                } else {
                    Text("수정 취소")
                        .font(.miniRegular)
                        .foregroundColor(.gray23)
                        .onTapGesture {
                            isEditMode = false
                            title = originTitle
                            context = originContext
                            date = originDate
                        }
                }
            }
        }
        .padding(.top, 25)
        .padding(.bottom, 28)
    }
    @ViewBuilder
    private func FullRecordView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if recordMode == .free {
                TextField("제목", text: $title)
                    .font(.bodyRegular)
                    .padding(.top, 2)
                    .foregroundColor(self.title == "제목" ? Color.grayA7 : Color.gray23)
                    .accentColor(Color.gray23)
                    .padding(.leading, 5)
                    .padding(.bottom, 22)
                    .disabled(!isEditMode)
            } else {
                Text(title)
                    .font(.bodyRegular)
                    .foregroundColor(.gray23)
                    .padding(.leading, 5)
                    .padding(.bottom, 22)
            }
            
//                WritingView(context: $context, date: date)
//                               .disabled(!isEditMode)
            #warning("이 부분 ... ^^")
            if isEditMode {
                WritingView(context: $context, date: date)
            } else {
            VStack(alignment: .leading, spacing: 0) {
                NavigationLink {
                    DateView(date: date, writingDate: $date)
                } label: {
                    Text(date.dateToString_MDY())
                        .font(.miniRegular)
                        .foregroundColor(Color.gray8A)
                        .padding(.bottom, 8)
                        .padding(.leading, 5)
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.grayF5)
                    .overlay(alignment: .topLeading) {
                        Text(context)
                            .foregroundColor(Color.gray23)
                            .font(.bodyRegular)
                            .background(Color.grayF5)
                            .lineSpacing()
                            .padding(.vertical, 23)
                            .padding(.horizontal, 20)
                            .textSelection(.disabled)
                        
                    }
                Spacer()
            }
            }
        }
    }
}

struct WritingEditView_Previews: PreviewProvider {
    static var previews: some View {
        WritingEditView(title: "단 한 가지 것에 집중한다면 무엇을 선택하고 싶나요?", date: Date(), context: "소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.  ", recordMode: Record.question)
    }
}
