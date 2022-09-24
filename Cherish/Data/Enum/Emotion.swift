//
//  Emotion.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/07.
//

import SwiftUI

enum EmotionCategory: CaseIterable {
    case joy
    case boredom
    case comfort
    case pleasure
    case depression
    case panic
    case anxiety
    case angry
    
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
}
