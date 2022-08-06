//
//  Question.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation

enum Question: CaseIterable {
    case life
    case person
    case love
    
    func questionText() -> String {
        switch self {
            case .life:
                return "삶"
            case .person:
                return "사람"
            case .love:
                return "사랑"
        }
    }
}
