//
//  Recode.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation
import SwiftUI

enum Record: String, CaseIterable {
    case free = "자유형식"
    case emotion = "감정형식"
    case question = "질문형식"
//    case inspiration = "영감형식"
    
    var writingMainText: String {
        switch self {
            case .free:
                return "머릿속 이야기"
            case .question:
                return "질문에 답하기"
            case .emotion:
                return "나의 감정"
//            case .inspiration:
//                return "영감 찾기"
        }
    }
    
    var color: Color {
        switch self {
            case .free:
                return Color(hex: "A2C691") ?? .clear
            case .emotion:
                return Color(hex: "ADD3E4") ?? .clear
            case .question:
                return Color(hex: "CEC8ED") ?? .clear
        }
    }
    
    var imageName: String {
        switch self {
            case .free:
                return "Free"
            case .question:
                return "Question"
            case .emotion:
                return "Emotion"
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

