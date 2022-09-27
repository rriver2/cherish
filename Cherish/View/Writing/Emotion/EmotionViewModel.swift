//
//  EmotionViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/15.
//

import SwiftUI

class EmotionViewModel: ObservableObject {
    @Published var isShowAlert: Bool
    @Published var context: String
    @Published var date: Date
    @Published var emotionType: EmotionCategory
    @Published var selectedEmotionList: [String]
    @Published var userDefaultEmotionList: [String] // for searchEmotion
    @Published var searchedEmotionList: [String]
    @Published var alertCategory: AlertCategory {
        didSet {
            if alertCategory == .save && isShowAlert == true {
                isShowSelectedEmotion = true
            }
        }
    }
    @Published var isShowWritingView = false
    @Published var isShowSelectedEmotion = true
    
    enum AlertCategory {
        case leave
        case save
        case tempWritingExistence
    }
    
    init() {
        isShowAlert = false
        context = "내용"
        date = Date()
        emotionType = EmotionCategory.allCases[0]
        selectedEmotionList = []
        let key = UserDefaultKey.selectedEmotion.rawValue
        userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
        searchedEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
        alertCategory = .tempWritingExistence
    }
    
    func appWillTerminate() {
        if !(selectedEmotionList.isEmpty && (context == "내용" || context == "")) {
            initTempWritingEmotion()
        }
    }
    
    func initTempWritingEmotion() {
        let key = UserDefaultKey.tempWritingEmotion.rawValue
        let emotionListString = selectedEmotionList.joined(separator: "    ")
        let tempWritingText = TempWritingText(title: emotionListString, context: context, date: date, kind: Record.free.rawValue)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempWritingText) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
    
    func getPreSelectedEmotion() -> [String] {
        let key = UserDefaultKey.selectedEmotion.rawValue
        return UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func tabEmotion(emotion: String) {
        if let index = selectedEmotionList.firstIndex(of: emotion) {
            selectedEmotionList.remove(at: index)
        } else if selectedEmotionList.count >= 6 {
            isShowAlert = true
            alertCategory = .save
        } else {
            selectedEmotionList.append(emotion)
        }
    }
    
    func deleteEmotionsOnDevice() {
        let key = UserDefaultKey.selectedEmotion.rawValue
        UserDefaults.standard.set([], forKey: key)
        userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func addEmotionToDevice(emotion: String) {
        if let index = userDefaultEmotionList.firstIndex(of: emotion) {
            userDefaultEmotionList.remove(at: index)
        } else if userDefaultEmotionList.count > 10 {
            userDefaultEmotionList.removeLast()
        }
        userDefaultEmotionList.insert(emotion, at: 0)
        let key = UserDefaultKey.selectedEmotion.rawValue
        UserDefaults.standard.set(userDefaultEmotionList, forKey: key)
        userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func showSelectingEmotionViewAlert(dismiss: DismissAction, tempWritingText: TempWritingText?) -> Alert{
        switch alertCategory {
            case .leave:
                let leaveButton = Alert.Button.cancel(Text("아니오")) {
                    let key = UserDefaultKey.tempWritingEmotion.rawValue
                    UserDefaults.standard.removeObject(forKey: key)
                    dismiss()
                }
                return Alert(title: Text("임시저장하시겠습니까?"), primaryButton: .destructive(Text("네"), action: {
                    self.initTempWritingEmotion()
                    dismiss()
                }), secondaryButton: leaveButton)
            case .save:
                if selectedEmotionList.isEmpty {
                    return Alert(title: Text("감정을 한 개 이상 선택해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
                } else {
                    return Alert(title: Text("6개 이하로 선택해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
                }
            case .tempWritingExistence:
                let newWritingButton = Alert.Button.cancel(Text("새 글 작성")) {
                    let key = UserDefaultKey.tempWritingEmotion.rawValue
                    UserDefaults.standard.removeObject(forKey: key)
                }
                return Alert(title: Text("작성 중인 글이 있습니다. 불러오시겠습니까?"), primaryButton: .destructive(Text("불러오기"), action: {
                    if let tempWritingText = tempWritingText {
                        self.selectedEmotionList = tempWritingText.title.components(separatedBy: "    ")
                        self.context = tempWritingText.context
                        self.date = tempWritingText.date
                        self.isShowWritingView = true
                    }
                }), secondaryButton: newWritingButton)
        }
    }
    
    func showEmotionViewAlert(dismiss: DismissAction) -> Alert {
            return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("확인")))
    }
}
