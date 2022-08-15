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
    
    init() {
        isShowAlert = false
        context = ""
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
        // 삭제하고 싶을 때
        // UserDefaults.standard.set([], forKey: UserDefaultKey.selectedEmotion.string)
        if let index = selectedEmotionList.firstIndex(of: emotion) {
            selectedEmotionList.remove(at: index)
        } else if selectedEmotionList.count >= 6 {
            isShowAlert = true
        } else {
            selectedEmotionList.append(emotion)
            let key = UserDefaultKey.selectedEmotion.string
            if !userDefaultEmotionList.contains(emotion) {
                if userDefaultEmotionList.count > 10 {
                    userDefaultEmotionList.removeLast()
                }
                userDefaultEmotionList.insert(emotion, at: 0)
                UserDefaults.standard.set(userDefaultEmotionList, forKey: key)
                userDefaultEmotionList = UserDefaults.standard.object(forKey: key) as? [String] ?? [String]()
            }
        }
    }
}
