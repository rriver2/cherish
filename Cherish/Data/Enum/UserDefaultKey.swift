//
//  UserDefaultKey.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/14.
//

import Foundation


enum UserDefaultKey: CaseIterable {
    case isMusicOn
    case oneSentence
    
    var string: String {
        switch self {
            case .isMusicOn:
                return "isMusicOn"
            case .oneSentence:
                return "oneSentence"
        }
    }
}
