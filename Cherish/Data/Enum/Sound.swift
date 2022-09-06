//
//  Sound.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/06.
//

import Foundation

enum SoundCategory: String, CaseIterable {
    case brightNightCity
    case gloriousBeach
    case earlySummerGrass
    case spaceSwimming
    
    var fileName: String {
        return self.rawValue.convertUppercaseFirstChar
    }
    
    var displayName: String {
        switch self {
            case .brightNightCity:
                return "밝은 밤 도시"
            case .gloriousBeach:
                return "찬란한 해변"
            case .earlySummerGrass:
                return "초여름 잔디"
            case .spaceSwimming:
                return "유영하는 우주"
        }
    }
}
