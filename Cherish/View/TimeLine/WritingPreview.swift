//
//  WritingPreview.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/24.
//
import SwiftUI

struct WritingPreview: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isEditMode: Bool
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    let recordMode: Record
    let title: String
    let date: Date
    let context: String
    @State var isShowAlert = false
    @State var alertCategory: AlertCategory = .remove
    
    enum AlertCategory {
    case remove
    case afterRemove
}
    
    init(title: String, date: Date, context: String, recordMode: Record, isEditMode: Binding<Bool>) {
        self.title = title
        self.date = date
        self.context = context
        self.recordMode = recordMode
        self._isEditMode = isEditMode
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            FullRecordView()
            Spacer()
        }
        .paddingHorizontal()
        .alert(isPresented: $isShowAlert) {
            showAlert()
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
        }
    }
}

extension WritingPreview {
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
    }
    @ViewBuilder
    private func FullRecordView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if title != "" {
                titleView(title)
            }
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

struct WritingPreview_Previews: PreviewProvider {
    static var previews: some View {
        WritingPreview(title: "단 한 가지 것에 집중한다면 무엇을 선택하고 싶나요?", date: Date(), context: "소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.소중한 것은 글자가 뜻하는 것처럼 힘을 들여 지켜야 하는 것임에도, 우리는 종종 말로만 그것을 소중하다 칭한 채, 방치한다. 그래서인지 가사 속에서 ‘소중하다’는 말은 주로 과거형으로 쓰이는 경우가 많다. 소 잃고 외양간 고치는 말 같기도 하지만, 세상의 모든 소중한 것들은 것을 소중하다 칭한 채, 방치한다.", recordMode: Record.question, isEditMode: .constant(false))
            .environmentObject(SoundViewModel())
    }
}
