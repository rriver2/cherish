//
//  Recode.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation
import SwiftUI

enum Record: String, CaseIterable {
    case emotion = "감정형식"
    case question = "질문형식"
    case free = "자유형식"
    
    var writingMainText: String {
        switch self {
            case .emotion:
                return "나의 감정"
            case .question:
                return "질문에 답하기"
            case .free:
                return "머릿속 이야기"
        }
    }
    
    var color: Color {
        switch self {
            case .free:
                return Color.cardGreen
            case .emotion:
                return Color.cardBlue
            case .question:
                return Color.cardPurple
        }
    }
    
    var popupColor: Color {
        switch self {
            case .free:
                return Color(hex: "EBF4E5") ?? .clear
            case .emotion:
                return Color(hex: "E9F4FB") ?? .clear
            case .question:
                return Color(hex: "F0EDFF") ?? .clear
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
            default:
                return .free
        }
    }
}

