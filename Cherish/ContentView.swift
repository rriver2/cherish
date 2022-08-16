//
//  ContentView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

enum tabbarCategory: String, CaseIterable{
    case writing = "writing"
    case timeLine = "timeLine"
    
    var imageName: String {
        switch self {
            case .writing:
                return "square.and.pencil"
            case .timeLine:
                return "book"
        }
    }
}

struct ContentView: View {
    @State private var selectedIndex = 0
    @State var isShowTabbar = true
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                    case 0:
                        WritingMainView(isShowTabbar: $isShowTabbar)
                    default:
                        TimelineView()
                }
            }
            .accentColor(Color.gray23)
            if isShowTabbar {
            HStack {
                Spacer()
                Spacer()
                ForEach(tabbarCategory.allCases.indices, id: \.self) { index in
                    let tabbarItem = tabbarCategory.allCases[index]
                    if index != 0 {
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    VStack {
                        Image(systemName: tabbarItem.imageName)
                            .font(.system(size: 20, weight: .regular))
                        Text(tabbarItem.rawValue)
                            .font(.system(size: 10, weight: .regular))
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                    .foregroundColor(selectedIndex == index ? Color.gray23 : Color.gray8A)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                selectedIndex = index
                            }
                    )
                }
                Spacer()
                Spacer()
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
