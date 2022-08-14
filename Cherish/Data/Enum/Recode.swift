//
//  Recode.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation

enum Record: String, CaseIterable {
    case free = "자유형식"
    case emotion = "감정형식"
    case question = "질문형식"
//    case inspiration = "영감형식"
    
    var writingMainText: String {
        switch self {
            case .free:
                return "머릿속 이야기 적기"
            case .question:
                return "질문에 답하기"
            case .emotion:
                return "나의 감정"
//            case .inspiration:
//                return "영감 찾기"
        }
    }
    
    var imageName: String {
        switch self {
            case .free:
                return "Ocean"
            case .question:
                return "Village"
            case .emotion:
                return "River"
//            case .inspiration:
//                return "Sky"
        }
    }
    
    static func getCatagory(record: String) -> Record {
        switch record {
            case Record.free.rawValue:
                return .free
            case Record.question.rawValue:
                return .question
            case Record.emotion.rawValue:
                return .emotion
//            case Record.inspiration.rawValue:
//                return .inspiration
            default:
                return .free
        }
    }
}

