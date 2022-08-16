//
//  FreeView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

enum AlertCategory {
    case leave
    case save
}

struct FreeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State private var title = "제목"
    @State private var context = "내용"
    @State private var isShowAlert = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var alertCategory: AlertCategory = .leave
    
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
                    
                    WritingView(context: $context)
                        .padding(.top, 25)
                        .padding(.horizontal, 27)
                    Spacer()
                }
            }
            .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
                if (value.translation.height > 100) {
                    if title != "제목" || context != "내용" {
                        isShowAlert = true
                        alertCategory = .leave
                    } else {
                        dismiss()
                    }
                }
            })
            .alert(isPresented: $isShowAlert) {
                switch alertCategory {
                    case .leave:
                        return Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                            dismiss()
                        }), secondaryButton: .cancel(Text("취소")))
                    case .save:
                        return Alert(title: Text("제목과 내용을 모두 입력해주세요"), message: nil, dismissButton: .cancel(Text("네")))
                }
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
                        if title == "제목" || context == "내용" || context == "" || title == "" {
                            isShowAlert = true
                            alertCategory = .save
                        } else {
                            timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.free)
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
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
                if title != "제목" || context != "내용" {
                    isShowAlert = true
                    alertCategory = .leave
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
}

struct FreeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeView()
//            .preferredColorScheme(.dark)
            .environmentObject(SoundViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
