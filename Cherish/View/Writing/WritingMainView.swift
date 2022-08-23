//
//  WritingMainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingMainView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isShowTabbar: Bool
    @State private var showFreeView = false
    @State private var showQuestionView = false
    @State private var showEmotionView = false
    @State private var showInspirationView = false
    @State private var showCards = true
    @FocusState private var isFocusedKeyboard: Bool
    @State var recordType = Record.free
    @State private var oneSentence: String = (UserDefaults.standard.object(forKey: UserDefaultKey.oneSentence.string) as? String ?? "")
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 0) {
                    Title()
                    OneSentence()
                        .padding(.horizontal, 27)
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
                .animation(Animation.easeOut, value: showCards)
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $showFreeView) {
                FreeView()
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
    private func OneSentence() -> some View {
        TextField("요즘 나의 한마디", text: $oneSentence)
            .frame(maxWidth: .infinity, minHeight: 52)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 17)
            .background(Color.grayF5)
            .font(oneSentence.count > 20 ? .miniRegular : .bodyRegular)
            .foregroundColor(Color.gray23)
            .cornerRadius(10)
            .padding(.bottom, 25)
            .onChange(of: oneSentence) { newValue in
                let key = UserDefaultKey.oneSentence.string
                UserDefaults.standard.set(newValue, forKey: key)
                let maxCharacterLength = 30
                if maxCharacterLength < newValue.count {
                    oneSentence = String(oneSentence.prefix(maxCharacterLength))
                }
            }
            .focused($isFocusedKeyboard)
            .onTapGesture {
                showCards = false
                isShowTabbar = false
                isFocusedKeyboard = true
            }
            .onSubmit {
                showCards = true
                isShowTabbar = true
            }
            .submitLabel(.done)
    }
    @ViewBuilder
    private func WritingBoxes() -> some View {
        ScrollView(.horizontal, showsIndicators : false){
            HStack(spacing: 0) {
                let records = Record.allCases
                let width = (UIScreen.main.bounds.height > 750) ? UIScreen.main.bounds.width/1.5 : UIScreen.main.bounds.width/1.8
                ForEach(records.indices, id: \.self){ index in
                    let record = records[index]
                    GeometryReader { geomitry in
                        ZStack(alignment: .center) {
                            Image(record.imageName)
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(Color.gray23)
                                .frame(width: width, height: width*1.5)
                            Text("\(record.writingMainText)")
                                .font(.bodySemibold)
                                .foregroundColor(colorScheme == .light ? .gray23 : .grayF5)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(.white.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.horizontal, 25)
                        }
                        .frame(width: width, height: width*1.5)
                        .cornerRadius(10)
                        .rotation3DEffect(.degrees(Double(geomitry.frame(in: .global).minX / -8)), axis: (x: 0.0, y: 0.0, z: 2.0))
                        .offset(x: 0, y: 50)
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
                .padding(.leading, 30)
                .padding(.trailing, 200)
            }
        }
    }
}

struct WritingMainView_Previews: PreviewProvider {
    static var previews: some View {
        WritingMainView(isShowTabbar: .constant(false))
            .preferredColorScheme(.dark)
            .environmentObject(SoundViewModel())
    }
}
