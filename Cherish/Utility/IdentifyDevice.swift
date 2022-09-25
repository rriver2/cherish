//
//  IdentifyDevice.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/25.
//

import SwiftUI

// 디바이스 모델명 / 7 보다 작으면 true 반환
func isDeviceUnderiPhone7() -> Bool {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let model = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch model {
        case "iPhone1,1", "iPhone1,2", "iPhone2,1", "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1", "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPhone7,1", "iPhone7,2", "iPhone8,1", "iPhone8,2", "iPhone8,4",  "iPhone9,1", "iPhone9,3", "iPhone10,1", "iPhone10,4", "iPhone10,2", "iPhone10,5":
            return true
        default:
            return false
    }
}
