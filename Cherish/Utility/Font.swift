//
//  Font.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

extension Font {
    static let miniRegular = Font.footnote.weight(.regular)
    static let bodyRegular = Font.body.weight(.regular)
    static let bodyRegularSmall = Font.callout.weight(.regular)
    static let bodySemibold = Font.body.weight(.bold)
    static let titleSemibold = Font.title2.weight(.bold)
    static let timeLineTitle = Font.system(size: 20).weight(.regular)
    static let timelineDate = Font.caption2.weight(.regular)
    static let miniSemibold = Font.footnote.weight(.bold)
    static let timelineRegular = Font.subheadline.weight(.regular)
    static let timelineSemibold = Font.subheadline.weight(.bold)
}

