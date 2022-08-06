//
//  Emotion.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/07.
//

import Foundation
import SwiftUI

enum EmotionCategory: CaseIterable {
    case angry
    case anxiety
    case depression
    case panic
    case joy
    case pleasure
    case boredom
    case comfort
    
    func emotionText() -> String {
        switch self {
            case .angry:
                return "분노"
            case .anxiety:
                return "불안/공포"
            case .depression:
                return "우울/슬픔"
            case .panic:
                return "당황"
            case .joy:
                return "기쁨"
            case .pleasure:
                return "즐거움"
            case .boredom:
                return "지루함"
            case .comfort:
                return "편안함"
        }
    }
    
    func emotionColor() -> Color {
        switch self {
            case .angry:
                return Color(hex: "F1B4B4")!
            case .anxiety:
                return Color(hex: "FAD6F6")!
            case .depression:
                return Color(hex: "CDEDFF")!
            case .panic:
                return Color(hex: "A9CEB4")!
            case .joy:
                return Color(hex: "F1EBB4")!
            case .pleasure:
                return Color(hex: "F1D5B4")!
            case .boredom:
                return Color(hex: "D5D0F2")!
            case .comfort:
                return Color(hex: "ADACB5")!
        }
    }
}
