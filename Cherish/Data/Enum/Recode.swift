//
//  Recode.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation

enum Record: CaseIterable {
    case free
    case emotion
    case question
    case inspiration
    
    func writingMainText() -> String {
        switch self {
            case .free:
                return "머릿속 이야기 적기"
            case .question:
                return "질문에 답하기"
            case .emotion:
                return "감정에 충실하기"
            case .inspiration:
                return "영감 찾기"
        }
    }
    
    func imageName() -> String {
        switch self {
            case .free:
                return "Ocean"
            case .question:
                return "Village"
            case .emotion:
                return "River"
            case .inspiration:
                return "Sky"
        }
    }
}

