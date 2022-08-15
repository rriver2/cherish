//
//  Font.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

extension Font {
    #warning("bigTitle 변경해야함") // bodyRegular의 경우 .lineSpacing(10) 넣어주기
    static let bigTitle = Font.title.weight(.bold)
    
    static let miniRegular = Font.footnote.weight(.regular)
    static let bodyRegular = Font.body.weight(.regular)
    static let bodyRegularSmall = Font.callout.weight(.regular)
    static let bodySemibold = Font.body.weight(.bold)
    static let titleSemibold = Font.title2.weight(.bold)
    static let timelineDate = Font.caption2.weight(.regular)
    static let miniSemibold = Font.footnote.weight(.bold)
    
//    bigTitle
//    body_regular_default
//    title1_bold
//    callout_regular
//    headline_regular_xmark
//    headline_semibold
//    caption2_regular
//    body_semibold
//    caption2_semibold
//    body_min2lines
//    body_regular_smaller
}

