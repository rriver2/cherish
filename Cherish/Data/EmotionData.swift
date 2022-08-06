//
//  EmotionData.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/07.
//

import Foundation

struct EmotionData {
    static let list : [EmotionCategory : [String]] = [
        .angry: ["화나다", "성가시다", "격분하다", "좌절감이 든다", "분하다", "열 받다", "거북하다", "짜증나다", "불편하다", "분노하다", "불안하다", "당혹스럽다","조바심이 나다", "혼란스럽다", "스트레스를 받는다"],
        .anxiety: ["두렵다", "무섭다", "속이 타다", "회의적이다", "신경이 쓰인다", "조심스럽다", "오싹하다", "초조하다", "막막하다", "암담하다", "공포스럽다", "섬뜩하다", "괴롭다", "긴장되다", "겁나다"],
        .depression: ["슬프다", "걱정스럽다", "안타깝다", "허탈하다", "서운하다", "울적하다", "후회스럽다", "마음이 아프다", "절망스럽다", "섭섭하다", "우울하다", "참담하다", "아쉽다", "실망하다", "낙담하다", "억울하다", "속상하다", "쓸쓸하다", "외롭다", "허전하다", "힘들다", "지친다", "답답하다", "공허하다", "미안하다"],
        .panic: ["무안하다", "당황하다", "민망하다", "멋쩍다", "무안하다", "어리둥절하다", "놀라다", "헷갈리다", "난처하다", "부끄럽다", "창피하다", "난감하다", "곤혹스럽다", "어색하다", "꺼림직하다"],
        .joy: ["기쁘다", "따뜻하다", "평온하다", "황홀하다", "여유롭다", "감사하다", "행복하다", "평화롭다", "경이롭다", "뿌듯하다", "흥분된다", "즐겁다", "홀가분하다", "통쾌하다", "자랑스럽다", "만족스럽다", "편안하다", "신뢰롭다", "기운이 난다", "후련하다", "흐뭇하다", "가슴이 뭉클하다", "감동하다", "든든하다", "용기가 난다"],
        .pleasure: ["재미있다", "상쾌하다", "신나다", "활기가 넘치다", "희망을 느끼다", "기대되다", "흥미롭다", "생기가 돌다", "다정하다", "반갑다", "끌리다", "짜릿하다", "개운하다", "좋아하다", "자신있다"],
        .boredom: ["지루하다", "따분하다", "심심하다", "지겹다", "질린다", "갑갑하다", "귀찮다", "무기력하다", "피곤하다", "실증나다"],
        .comfort: ["긴장이 풀리다", "느긋하다", "마음이 놓이다", "안심이 되다"]
    ]
    
    static func findEmotionCategory(emotion: String) -> EmotionCategory {
        // TODO: error 처리 해야함
        for detailEmotionList in list {
            if detailEmotionList.value.contains(emotion) { return detailEmotionList.key }
        }
        return .angry
    }
    
    static var allList: [String] = {
        var detailAllEmotionList: [String] = []
        let emotionList = EmotionCategory.allCases
        for index in emotionList.indices {
            let emotion = emotionList[index]
            detailAllEmotionList += EmotionData.list[emotion]!
        }
        return detailAllEmotionList
    }()
    
}
