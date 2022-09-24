//
//  QuestionViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/24.
//

import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var title: String
    @Published var context: String
    @Published var date: Date
    
    init() {
        title = ""
        context = "내용"
        date = Date()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillTerminate),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
    }
    
    @objc func appWillTerminate() {
        if !(context == "내용" || context == "") {
            initTempWritingQuestion()
        }
    }
    
    func initTempWritingQuestion() {
        let key = UserDefaultKey.tempWritingQuestion.rawValue
        let tempWritingText = TempWritingText(title: title, context: context, date: date, kind: Record.free.rawValue)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempWritingText) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
}
