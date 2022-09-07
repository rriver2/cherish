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
    
    var license: String? {
        switch self {
            case .brightNightCity:
                return "Cozy Place by Keys of Moon | https://soundcloud.com/keysofmoon Music promoted by https://www.chosic.com/free-music/all/   Creative Commons CC BY 4.0m https://creativecommons.org/licenses/by/4.0/"
            case .gloriousBeach:
                return nil
            case .earlySummerGrass:
                return "Uplifting Piano by LesFM | https://lesfm.net/ Music promoted by https://www.chosic.com/free-music/all/ Creative Commons CC BY 3.0 https://creativecommons.org/licenses/by/3.0/"
            case .spaceSwimming:
                return "Soon We’ll Fly by Ghostrifter Official | https://soundcloud.com/ghostrifter-official Creative Commons — Attribution-NoDerivs 3.0 Unported — CC BY-ND 3.0 Music promoted by https://www.chosic.com/free-music/all/"
        }
    }
}
