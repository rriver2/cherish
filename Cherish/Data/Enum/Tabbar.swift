//
//  Tabbar.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/22.
//

import Foundation

enum TabbarCategory: String, CaseIterable{
    case writing = "writing"
    case timeline = "timeline"
    case setting = "setting"
    
    var imageName: String {
        switch self {
            case .writing:
                return "square.and.pencil"
            case .timeline:
                return "book"
            case .setting:
                return "gearshape"
        }
    }
}
