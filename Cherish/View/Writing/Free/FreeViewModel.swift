//
//  FreeViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/13.
//

import SwiftUI
#warning("TempWritingText 이동 필요")
struct TempWritingText: Codable {
    let title: String
    let context: String
    let date: Date
    let kind: String
}

class FreeViewModel: ObservableObject {
    @Published var title: String
    @Published var context: String
    @Published var date: Date
    
    init() {
        title = ""
        context = "오늘의 이야기를 기록해보세요."
        date = Date()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillTerminate),
            name: UIApplication.willTerminateNotification,
            object: nil
        )
    }
    
    @objc func appWillTerminate() {
        let key = UserDefaultKey.tempWriting.rawValue
        let tempWritingText = TempWritingText(title: title, context: context, date: date, kind: Record.free.rawValue)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempWritingText) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
        print("dmksaksa")
    }
}
