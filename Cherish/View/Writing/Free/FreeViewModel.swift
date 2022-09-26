//
//  FreeViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/13.
//

import SwiftUI

class FreeViewModel: ObservableObject {
    @Published var title: String
    @Published var context: String
    @Published var date: Date
    
    init() {
        title = ""
        context = "오늘의 이야기를 기록해보세요."
        date = Date()
    }
    
    func appWillTerminate() {
        if !(title == "" && (context == "오늘의 이야기를 기록해보세요." || context == "")) {
            initTempWritingFree()
        }
    }
    
    func initTempWritingFree() {
        let key = UserDefaultKey.tempWritingFree.rawValue
        let tempWritingText = TempWritingText(title: title, context: context, date: date, kind: Record.free.rawValue)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempWritingText) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
    }
}
