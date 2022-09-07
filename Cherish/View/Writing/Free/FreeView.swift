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
    @State private var title = "제목"
    @State private var context = "오늘의 이야기를 기록해보세요."
    @State private var isShowAlert = false
    @State private var alertCategory: AlertCategory = .leave
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    
    init() {
        UIToolbar.appearance().barTintColor = UIColor.systemGray5
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                ScrollView(showsIndicators : false) {
                    TextEditor(text: $title)
                        .onTapGesture {
                            if self.title == "제목"{
                                self.title = ""
                            }
                        }
                        .font(.bodyRegular)
                        .padding(.horizontal, 27)
                        .padding(.top, 2)
                        .foregroundColor(self.title == "제목" ? Color.grayA7 : Color.gray23)
                        .accentColor(Color.gray23)
                    
                    WritingView(context: $context, contextPlaceholder: "오늘의 이야기를 기록해보세요.")
                        .padding(.top, 25)
                        .padding(.horizontal, 27)
                    Spacer()
                }
            }
            .alert(isPresented: $isShowAlert) {
                saveAlert()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                        .font(.bodyRegular)
                    Spacer()
                    
                    //                    #warning("삭제하기")
                    //                    Button {
                    //                        timeLineViewModel.removeAll()
                    //                        dismiss()
                    //                    } label: {
                    //                        Text("삭제")
                    //                    }
                    
                    Button {
                        if context == "오늘의 이야기를 기록해보세요." || context == "" {
                            isShowAlert = true
                            alertCategory = .save
                        } else {
                            timeLineViewModel.addRecord(date: Date(), title: title == "제목" ? "" : title, context: context, kind: Record.free)
                            addWritingPopupViewModel.isShowAddWritingPopup = true
                            addWritingPopupViewModel.writingCategory = .free
                            dismiss()
                        }
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
            .textInputAutocapitalization(.never)
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
        .padding(.horizontal, 27)
    }
    private func saveAlert() -> Alert {
        switch alertCategory {
            case .leave:
                return Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                    dismiss()
                }), secondaryButton: .cancel(Text("머무르기")))
            case .save:
                return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("네")))
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
