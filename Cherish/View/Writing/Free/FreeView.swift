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
    @StateObject private var freeViewModel = FreeViewModel()
    @State private var isShowAlert: Bool
    @State private var alertCategory: AlertCategory = .tempWritingExistence
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    @FocusState var isTextFieldsFocused: Bool
    @State var isEditMode = false
    @State var isKeyBoardOn = false
    let tempWritingText: TempWritingText?
    
    enum AlertCategory {
        case leave
        case save
        case tempWritingExistence
    }
    
    init() {
        UIToolbar.appearance().barTintColor = UIColor.systemGray5
        
        let key = UserDefaultKey.tempWritingFree.rawValue
        if let savedTempWritingText = UserDefaults.standard.object(forKey: key) as? Data,
           let loadedTempWritingText = try? JSONDecoder().decode(TempWritingText.self, from: savedTempWritingText),
           loadedTempWritingText.kind == Record.free.rawValue {
            self.tempWritingText = TempWritingText(title: loadedTempWritingText.title, context: loadedTempWritingText.context, date: loadedTempWritingText.date, kind: loadedTempWritingText.kind)
            self._isShowAlert = State(initialValue: true)
        } else {
            self._isShowAlert = State(initialValue: false)
            self.tempWritingText = nil
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar()
                TextField("제목", text: $freeViewModel.title)
                    .font(.bodyRegular)
                    .padding(.top, 2)
                    .foregroundColor(freeViewModel.title == "제목" ? Color.grayA7 : Color.gray23)
                    .accentColor(Color.gray23)
                    .padding(.leading, 5)
                    .focused($isTextFieldsFocused)
                    .onChange(of: isEditMode) { newValue in
                        if isEditMode {
                            isTextFieldsFocused = true
                        }
                    }
                
#warning("수정해야 함")
                if isEditMode {
                    let isContextDiff = freeViewModel.context != "오늘의 이야기를 기록해보세요."
                    WritingView(date: $freeViewModel.date, context: $freeViewModel.context, contextPlaceholder: "오늘의 이야기를 기록해보세요.", isKeyBoardOn: false, isEditMode: isContextDiff)
                        .padding(.top, 25)
                } else {
                    WritingView(date: $freeViewModel.date, context: $freeViewModel.context, contextPlaceholder: "오늘의 이야기를 기록해보세요.", isKeyBoardOn: false, isEditMode: false)
                        .padding(.top, 25)
                }
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
                        if freeViewModel.context == "오늘의 이야기를 기록해보세요." || freeViewModel.context == "" {
                            isShowAlert = true
                            alertCategory = .save
                        } else {
                            timeLineViewModel.addRecord(date: freeViewModel.date, title: freeViewModel.title == "제목" ? "" : freeViewModel.title, context: freeViewModel.context, kind: Record.free)
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
                if !isShowAlert{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)
                    {
                        isTextFieldsFocused = true
                    }
                }
            }
        }
        .tint(Color.gray23)
    }
    
    private func saveAlert() -> Alert {
        switch alertCategory {
            case .leave:
                let leaveButton = Alert.Button.cancel(Text("아니오")) {
                    let key = UserDefaultKey.tempWritingFree.rawValue
                    UserDefaults.standard.removeObject(forKey: key)
                    dismiss()
                }
                return Alert(title: Text("임시저장하시겠습니까?"), primaryButton: .destructive(Text("네"), action: {
                    freeViewModel.initTempWritingFree()
                    dismiss()
                }), secondaryButton: leaveButton)
            case .save:
                return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
            case .tempWritingExistence:
                let newWritingButton = Alert.Button.cancel(Text("새 글 작성")) {
                    let key = UserDefaultKey.tempWritingFree.rawValue
                    UserDefaults.standard.removeObject(forKey: key)
                    self.isKeyBoardOn = true
                    self.isEditMode = true
                }
                return Alert(title: Text("작성 중인 글이 있습니다. 불러오시겠습니까?"), primaryButton: .destructive(Text("불러오기"), action: {
                    if let tempWritingText = tempWritingText {
                        self.freeViewModel.title = tempWritingText.title
                        self.freeViewModel.context = tempWritingText.context
                        self.freeViewModel.date = tempWritingText.date
                        self.isKeyBoardOn = true
                        self.isEditMode = true
                    }
                }), secondaryButton: newWritingButton)
        }
    }
    private func checkShouldShowAlert() -> Bool {
        if ( freeViewModel.context == "오늘의 이야기를 기록해보세요." && freeViewModel.title == "제목") { return false }
        else if  ( freeViewModel.context == "오늘의 이야기를 기록해보세요." && freeViewModel.title == "") { return false }
        else if  ( freeViewModel.context == "" && freeViewModel.title == "제목") { return false }
        else if  ( freeViewModel.context == "" && freeViewModel.title == "") { return false }
        else { return true }
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
