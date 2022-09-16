//
//  WritingSequenceView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/07.
//

import SwiftUI

struct WritingSequenceView: View {
    @Binding var isShowTabbar: Bool
    @Environment(\.dismiss) private var dismiss
    @State var cardSequence: [Record]
    
    init(isShowTabbar: Binding<Bool>) {
        self._isShowTabbar = isShowTabbar
        if let cardSequenceString = UserDefaults.standard.object(forKey: UserDefaultKey.cardSequence.rawValue) as? [String] {
            self._cardSequence = State(initialValue: cardSequenceString.map{Record(rawValue: $0) ?? Record.emotion})
        } else {
            self._cardSequence = State(initialValue: Record.allCases)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
                .paddingHorizontal()
                .padding(.bottom, 30)
            List {
                ForEach(cardSequence, id: \.self) { card in
                    let cardTitle = card.writingMainText
                    Text("\(cardTitle)")
                        .listRowInsets(.init())
                        .padding(.vertical, 20)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .onMove { (source: IndexSet, destination: Int) -> Void in
                    self.cardSequence.move(fromOffsets: source, toOffset: destination)
                }
            }
            .paddingHorizontal()
            .padding(.trailing, 10)
            .listStyle(.plain)
            .environment(\.editMode, .constant(.active))
            .onChange(of: cardSequence) { newValue in
                let key = UserDefaultKey.cardSequence.rawValue
                let inputCardSequence = cardSequence.map{ $0.rawValue }
                UserDefaults.standard.set(inputCardSequence, forKey: key)
            }
        }
        .onAppear {
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension WritingSequenceView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyRegular)
            }
            Spacer()
            Text("일기 형식 순서")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Rectangle()
                .frame(width: 13, height: 9)
                .font(.bodyRegular)
                .foregroundColor(.clear)
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .padding(.bottom, 40)
    }
}

struct WritingSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        WritingSequenceView(isShowTabbar: .constant(false))
    }
}
