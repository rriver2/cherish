//
//  WritingMainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingMainView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var addWritingPopupViewModel: AddWritingPopupViewModel
    @Binding var isShowTabbar: Bool
    @State private var showFreeView = false
    @State private var showQuestionView = false
    @State private var showEmotionView = false
    @State private var showInspirationView = false
    @State private var showCards = true
    @FocusState private var isFocusedKeyboard: Bool
    @State var recordType = Record.free
    @State private var oneSentence: String = (UserDefaults.standard.object(forKey: UserDefaultKey.oneSentence.rawValue) as? String ?? "")
    @Binding var tabbarCategory: TabbarCategory
    @State var cardSequence: [Record]
    
    init(isShowTabbar: Binding<Bool>, tabbarCategory: Binding<TabbarCategory>) {
        self._isShowTabbar = isShowTabbar
        self._tabbarCategory = tabbarCategory
        if let cardSequenceString = UserDefaults.standard.object(forKey: UserDefaultKey.cardSequence.rawValue) as? [String] {
            self._cardSequence = State(initialValue: cardSequenceString.map{Record(rawValue: $0) ?? Record.emotion})
        } else {
            self._cardSequence = State(initialValue: Record.allCases)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 0) {
                    Title()
                    if addWritingPopupViewModel.isShowAddWritingPopup {
                        AddWritingPopup()
                            .padding(.horizontal, 27)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                    addWritingPopupViewModel.isShowAddWritingPopup = false
                                }
                            }
                    } else {
                        OneSentence()
                            .padding(.horizontal, 27)
                    }
                    if showCards {
                        WritingBoxes()
                    } else {
                        Rectangle()
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .onTapGesture {
                                showCards = true
                                isShowTabbar = true
                                isFocusedKeyboard = false
                            }
                    }
                    Spacer()
                }
                .animation(Animation.easeInOut(duration: 0.8), value: addWritingPopupViewModel.isShowAddWritingPopup)
                .animation(Animation.easeOut, value: showCards)
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showFreeView) {
                FreeView()
//                WritingView(context: .constant("dd"))
            }
            .fullScreenCover(isPresented: $showQuestionView) {
                RecommandedQuestionView(isModalShow: $showQuestionView)
            }
            .fullScreenCover(isPresented: $showEmotionView) {
                SelectingEmotionView(isModalShow: $showEmotionView)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .ignoresSafeArea(.keyboard)
    }
}

extension WritingMainView {
    @ViewBuilder
    private func Title() -> some View {
        HStack(spacing: 0) {
            Text("Cherish")
                .kerning(3)
                .foregroundColor(Color.gray23)
                .padding(.leading, 3)
            Spacer()
            if showCards {
                SoundView()
            }
        }
        .frame(height: 20)
        .padding(.horizontal, 27)
        .padding(.bottom, 49)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
    }
    @ViewBuilder
    private func AddWritingPopup() -> some View {
        Button {
            tabbarCategory = .timeline
            addWritingPopupViewModel.isShowAddWritingPopup = false
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 39, height: 39)
                Text("새로운 일기가 등록되었어요!")
                    .font(.bodyRegular)
                    .foregroundColor(Color(hex: "232323"))
                Spacer()
                Text("보러가기")
                    .font(.timelineDate)
                    .foregroundColor(Color(hex: "8A8A8A"))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 52)
        .padding(.horizontal, 17)
        .background(addWritingPopupViewModel.writingCategory.popupColor)
        .font(.bodyRegular)
        .cornerRadius(10)
        .padding(.bottom, 25)
    }
    @ViewBuilder
    private func OneSentence() -> some View {
        HStack(spacing: 0) {
            TextField("나의 다짐", text: $oneSentence)
                .multilineTextAlignment(.center)
                .padding(.leading, 17)
                .font(oneSentence.count > 20 ? .miniRegular : .bodyRegular)
                .foregroundColor(Color.gray23)
                .focused($isFocusedKeyboard)
                .onSubmit {
                    showCards = true
                    isShowTabbar = true
                }
                .submitLabel(.done)
            if oneSentence != "" && showCards == false {
                Button(action: {
                    oneSentence = ""
                    showCards = true
                    isShowTabbar = true
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.gray23.opacity(0.5))
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 17)
                        .background(Color.grayF5)
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 52)
        .background(Color.grayF5)
        .cornerRadius(10)
        .padding(.bottom, 25)
        .onChange(of: oneSentence) { newValue in
            let key = UserDefaultKey.oneSentence.rawValue
            UserDefaults.standard.set(newValue, forKey: key)
            let maxCharacterLength = 25
            if maxCharacterLength < newValue.count {
                oneSentence = String(oneSentence.prefix(maxCharacterLength))
            }
        }
        .onTapGesture {
            showCards = false
            isShowTabbar = false
            isFocusedKeyboard = true
        }
    }
    @ViewBuilder
    private func WritingBoxes() -> some View {
        ScrollView(.horizontal, showsIndicators : false){
            HStack(spacing: 0) {
                let width = (UIScreen.main.bounds.height > 750) ? UIScreen.main.bounds.width/1.5 : UIScreen.main.bounds.width/1.8
                ForEach(cardSequence.indices, id: \.self){ index in
                    let record = cardSequence[index]
                    GeometryReader { geomitry in
                        ZStack(alignment: .center) {
                            Image(record.imageName)
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(Color.gray23)
                                .frame(width: width, height: width*1.5)
                            Text("\(record.writingMainText)")
                                .font(.bodySemibold)
                                .foregroundColor(colorScheme == .light ? Color(hex: "4A4A4A") : .grayF5)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(.white.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.horizontal, 25)
                        }
                        .frame(width: width, height: width*1.5)
                        .cornerRadius(10)
                        .offset(x: width/4, y: 50)
                        .rotation3DEffect(.degrees(Double(geomitry.frame(in: .global).minX / -8)), axis: (x: 0.0, y: 0.0, z: 2.0))
                        .onTapGesture {
                            switch record {
                                case .free:
                                    showFreeView = true
                                case .question:
                                    showQuestionView = true
                                case .emotion:
                                    showEmotionView = true
                            }
                        }
                    }
                    .frame(width: width/2.2)
                    .shadow(color: (colorScheme == .light ? .gray.opacity(0.5) : .clear ), radius: 7, x: 10, y:10)
                }
                .padding(.trailing, 200)
            }
            .padding(.trailing, 100)
        }
    }
}

struct WritingMainView_Previews: PreviewProvider {
    static var previews: some View {
        WritingMainView(isShowTabbar: .constant(false), tabbarCategory: .constant(.writing))
            .preferredColorScheme(.dark)
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
            .environmentObject(AddWritingPopupViewModel())
    }
}
