//
//  FreeView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct FreeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State private var date = Date()
    @State private var title = ""
    @State private var context = "오늘의 이야기를 기록해보세요."
    @State private var isShowAlert = false
    @State private var alertCategory: AlertCategory = .leave
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    @FocusState var isTextFieldsFocused: Bool
    
    init() {
        UIToolbar.appearance().barTintColor = UIColor.systemGray5
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                TextField("제목", text: $title)
                    .font(.bodyRegular)
                    .padding(.top, 2)
                    .foregroundColor(self.title == "제목" ? Color.grayA7 : Color.gray23)
                    .accentColor(Color.gray23)
                    .padding(.leading, 5)
                    .focused($isTextFieldsFocused)
                
                WritingView(date: $date, context: $context, contextPlaceholder: "오늘의 이야기를 기록해보세요.", isKeyBoardOn: false)
                    .padding(.top, 25)
            }
            .paddingHorizontal()
            .alert(isPresented: $isShowAlert) {
                saveAlert()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                        .font(.system(size: 16))
                    Spacer()
                    Button {
                        if context == "오늘의 이야기를 기록해보세요." || context == "" {
                            isShowAlert = true
                            alertCategory = .save
                        } else {
                            timeLineViewModel.addRecord(date: date, title: title == "제목" ? "" : title, context: context, kind: Record.free)
                            addWritingPopupViewModel.isShowAddWritingPopup = true
                            addWritingPopupViewModel.writingCategory = .free
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16))
                            .foregroundColor(.gray23)
                    }
                }
            }
            .textInputAutocapitalization(.never)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                {
                    isTextFieldsFocused = true
                }
            }
        }
        .tint(Color.gray23)
    }
}

extension FreeView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                if checkShouldShowAlert() {
                    alertCategory = .leave
                    isShowAlert = true
                } else {
                    dismiss()
                }
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
                    .padding(.trailing, 18)
            }
            Spacer()
            Text(Record.free.writingMainText)
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Image(systemName: "xmark")
                .font(.bodyRegular)
                .foregroundColor(.clear)
                .padding(.trailing, 18)
        }
        .padding(.top, 25)
        .padding(.bottom, 28)
    }
    private func saveAlert() -> Alert {
        switch alertCategory {
            case .leave:
                return Alert(title: Text("기록한 내용은 저장되지 않습니다."), message: Text("그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                    dismiss()
                }), secondaryButton: .cancel(Text("머무르기")))
            case .save:
                return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
        }
    }
    private func checkShouldShowAlert() -> Bool {
        if ( context == "오늘의 이야기를 기록해보세요." && title == "제목") { return false }
        else if  ( context == "오늘의 이야기를 기록해보세요." && title == "") { return false }
        else if  ( context == "" && title == "제목") { return false }
        else if  ( context == "" && title == "") { return false }
        else { return true }
    }
}

struct FreeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeView()
        //            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
