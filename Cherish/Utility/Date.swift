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
    func dateToString_HS() -> (hour: Int, minute: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH mm"
        let hour = formatter.string(from: self).components(separatedBy: " ")[0]
        let minute = formatter.string(from: self).components(separatedBy: " ")[1]
        let tupleHS = (hour: Int(hour) ?? 0 , minute: Int(minute) ?? 0)
        return tupleHS
    }
}
