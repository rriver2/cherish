//
//  EmotionViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/15.
//

import SwiftUI
import AVFAudio

class EmotionViewModel: ObservableObject {
    @Published var isShowAlert: Bool
    @Published var context: String
    @Published var emotionType: EmotionCategory
    @Published var selectedEmotionList: [String]
    @Published var userDefaultEmotionList: [String]
    @Published var searchedEmotionList: [String]
    @Published var alertCategory: AlertCategory = .leave
    
    init() {
        isShowAlert = false
        context = "내용"
        emotionType = EmotionCategory.allCases[0]
        selectedEmotionList = []
        let key = UserDefaultKey.selectedEmotion.string
        userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
        searchedEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func getPreSelectedEmotion() -> [String] {
        let key = UserDefaultKey.selectedEmotion.string
        return UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func tabEmotion(emotion: String) {
        if let index = selectedEmotionList.firstIndex(of: emotion) {
            selectedEmotionList.remove(at: index)
        } else if selectedEmotionList.count >= 6 {
            alertCategory = .save
            isShowAlert = true
        } else {
            selectedEmotionList.append(emotion)
        }
    }
    
    func deleteEmotionsOnDevice() {
        let key = UserDefaultKey.selectedEmotion.string
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
        let key = UserDefaultKey.selectedEmotion.string
        UserDefaults.standard.set(userDefaultEmotionList, forKey: key)
        userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
    }
    
    func showSelectingEmotionViewAlert(dismiss: DismissAction) -> Alert{
        switch alertCategory {
            case .leave:
                return Alert(title: Text("기록한 내용은 저장되지 않습니다. 그래도 나가시겠습니까?"), primaryButton: .destructive(Text("나가기"), action: {
                    dismiss()
                }), secondaryButton: .cancel(Text("머무르기")))
            case .save:
                if selectedEmotionList.isEmpty {
                    return Alert(title: Text("감정을 한 개 이상 선택해주세요"), message: nil, dismissButton: .cancel(Text("네")))
                } else {
                    return Alert(title: Text("6개 이하로 선택해주세요"), message: nil, dismissButton: .cancel(Text("네")))
                }
        }
    }
    
    func showEmotionViewAlert(dismiss: DismissAction) -> Alert {
            switch alertCategory {
                case .leave:
                    let firstButton = Alert.Button.cancel(Text("감정 다시 선택하기")) {
                        self.selectedEmotionList = []
                        dismiss()
                    }
                    let secondButton = Alert.Button.default(Text("머무르기").foregroundColor(.red))
                    return Alert(title: Text("감정을 다시 선택하시겠습니까?"),
                                 message: Text("작성한 내용은 사라지지 않습니다."),
                                 primaryButton: firstButton, secondaryButton: secondButton)
                case .save:
                    return Alert(title: Text("내용을 입력해주세요"), message: nil, dismissButton: .cancel(Text("네")))
            }
    }
}
