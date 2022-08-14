//
//  Date.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation

extension Date {
    func dateToString_MDY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let koreanDate = formatter.string(from: self)
        return koreanDate
    }
    func dateToString_DW() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d (EEE)"
        let koreanDate = formatter.string(from: self)
        return koreanDate
    }
    func dateToString_MY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        let koreanDate = formatter.string(from: self)
        return koreanDate
    }
}
