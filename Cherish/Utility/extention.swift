//
//  extension.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

extension UINavigationController {
    // Remove back button text 
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

extension View {
    var dividerGrayE8 : some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.grayE8)
    }
    var dividerThickGrayE8 : some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(Color.grayE8)
    }
    var dividerGray8A : some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray8A)
    }
    var dividerThickGray8A : some View {
        Rectangle()
            .frame(height: 4)
            .foregroundColor(Color.gray8A)
    }
    func lineSpacing() -> some View {
        self
            .lineSpacing(8.0)
    }
}
