//
//  Recordable.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import Foundation

protocol Recordable {
    var type: Record { get }
    var date: Date { get }
    var title: String { get }
    var content: String { get }
}
