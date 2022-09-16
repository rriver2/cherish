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
    @State var alertCategory: AlertCategory = .remove
    @FocusState var isTextFieldsFocused: Bool
    
    let originTitle: String
    let originDate: Date
    let originContext: String
    
    enum AlertCategory {
        case remove
        case afterRemove
        case leave
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
            .paddingHorizontal()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                        .font(.bodyRegular)
                    Spacer()
                    Button {
                        timeLineViewModel.updateRecord(originDate: originDate, date: date, title: title, context: context)
                        print("updateRecord")
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16))
                            .foregroundColor(.gray23)
                    }
                }
            }
            .alert(isPresented: $isShowAlert) {
                showAlert()
            }
        }
    }
    
    private func showAlert() -> Alert {
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
                    dismiss()
                }), secondaryButton: .cancel(Text("머무르기")))
        }
    }
}

extension WritingEditView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(recordMode.writingMainText)
                    .font(.bodySemibold)
                    .foregroundColor(Color.gray23)
                Spacer()
            }
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    if originTitle == title && originDate == date && originContext == context {
                        dismiss()
                    } else {
                        alertCategory = .leave
                        isShowAlert = true
                    }
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
                            alertCategory = .remove
                            isShowAlert = true
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
            if recordMode == .free && isEditMode {
                TextField("제목", text: $title)
                    .font(.bodyRegular)
                    .padding(.top, 2)
                    .foregroundColor(self.title == "제목" ? Color.grayA7 : Color.gray23)
                    .accentColor(Color.gray23)
                    .padding(.leading, 5)
                    .padding(.bottom, 22)
                    .disabled(!isEditMode)
                    .focused($isTextFieldsFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                        {
                            isTextFieldsFocused = true
                        }
                    }
            } else if title != "" {
                Text(title)
                    .font(.bodyRegular)
                    .foregroundColor(.gray23)
                    .padding(.leading, 5)
                    .padding(.bottom, 22)
            }
            //
            //                WritingView(context: $context, date: date)
            //                               .disabled(!isEditMode)
#warning("이 부분 ... ^^")
            if isEditMode {
                WritingView(date: $date, context: $context, isKeyBoardOn: recordMode != .free, isEditMode: true)
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    Text(date.dateToString_MDY())
                        .font(.miniRegular)
                        .foregroundColor(Color.gray8A)
                        .padding(.bottom, 8)
                        .padding(.leading, 5)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.grayF5)
                        .overlay(alignment: .topLeading) {
                            ScrollView {
                                Text(context)
                                    .foregroundColor(Color.gray23)
                                    .font(.bodyRegular)
                                    .background(Color.grayF5)
                                    .lineSpacing()
                                    .padding(.horizontal, 10)
                            }
                            .padding(.vertical, 23)
                            .padding(.horizontal, 20)
                            .cornerRadius(10)
                        }
                    Spacer()
                }
            }
        }
    }
}

struct WritingEditView_Previews: PreviewProvider {
    static var previews: some View {
        WritingEditView(title: "단 한 가지 것에 집중한다면 무엇을 선택하고 싶나요?", date: Date(), context: "소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.", recordMode: Record.question)
            .environmentObject(SoundViewModel())
    }
}
