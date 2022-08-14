//
//  Emotion.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/07.
//

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
    
    var string: String {
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
    
    // TODO: 삭제해야 할지도 ?
    var color: Color {
        switch self {
            case .angry:
                return Color(hex: "F1B4B4") ?? .clear
            case .anxiety:
                return Color(hex: "FAD6F6") ?? .clear
            case .depression:
                return Color(hex: "CDEDFF") ?? .clear
            case .panic:
                return Color(hex: "A9CEB4") ?? .clear
            case .joy:
                return Color(hex: "F1EBB4") ?? .clear
            case .pleasure:
                return Color(hex: "F1D5B4") ?? .clear
            case .boredom:
                return Color(hex: "D5D0F2") ?? .clear
            case .comfort:
                return Color(hex: "ADACB5") ?? .clear
        }
    }
}
