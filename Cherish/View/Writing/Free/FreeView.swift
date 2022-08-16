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
    @State private var context = "내용"
    @State private var isShowAlert = false
    @GestureState private var dragOffset = CGSize.zero
    
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
                        .frame(minHeight: 20)
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
                    } else {
                        dismiss()
                    }
                }
            })
            .alert(isPresented: $isShowAlert) {
                Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                    dismiss()
                }), secondaryButton: .cancel(Text("취소")))
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                        .font(.bodyRegular)
                    Spacer()
                    
                    #warning("삭제하기")
                    Button {
                        timeLineViewModel.removeAll()
                        dismiss()
                        
                    } label: {
                        Text("삭제")
                    }
                    
                    Button {
                        timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.free)
                        dismiss()
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
            .environmentObject(SoundViewModel())
            .environmentObject(TimeLineViewModel())
    }
}
