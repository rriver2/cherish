//
//  extension.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
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
    var dividerThickClear : some View {
        Rectangle()
            .frame(height: 4)
            .foregroundColor(Color.clear)
    }
    func titleView(_ title: String) -> some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.bodyRegular)
            .lineSpacing()
            .foregroundColor(Color.gray23)
            .padding(.leading, 5)
    }
    func lineSpacing() -> some View {
        self
            .lineSpacing(8.0)
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    func paddingHorizontal() -> some View {
        self
            .padding(.horizontal, 27)
    }
}

extension String {
    var convertUppercaseFirstChar: String {
        var string = self
        string.removeFirst()
        let firstChar = self.first?.uppercased() ?? ""
        return firstChar + string
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
