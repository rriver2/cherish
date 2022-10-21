//
//  ReviewManager.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/26.
//

import StoreKit

class ReviewManager {
    static func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    static func shouldRequestReview() {
        let key = UserDefaultKey.requestReviewCount.rawValue
        
        var requestReviewCount = UserDefaults.standard.object(forKey: key) as? Int ?? 0
        if requestReviewCount == 10 {
            ReviewManager.requestReview()
        }
        requestReviewCount += 1
        UserDefaults.standard.setValue(requestReviewCount, forKey: key)
    }
}
