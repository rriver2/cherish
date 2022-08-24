//
//  AddWritingPopupViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/24.
//

import SwiftUI

class AddWritingPopupViewModel: ObservableObject {
    @Published var isShowAddWritingPopup = false
    @Published var writingCategory: Record = .free
}
