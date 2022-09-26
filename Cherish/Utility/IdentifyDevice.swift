//
//  IdentifyDevice.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/25.
//

import SwiftUI

enum DeviceScreenHeight {
    case small
    case middle
    case big
}

func getDeviceScreenHeight() -> DeviceScreenHeight {
    let screenSize = UIScreen.main.bounds
    let screenHeight = screenSize.height
    if screenHeight < 667.0 { // iphone 8 이하
        return .small
    } else if screenHeight == 667.0 { // iphone 8, SE2
        return .middle
    } else { // iphone 8 plus 이상
        return .big
    }
}
