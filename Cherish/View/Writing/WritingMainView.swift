//
//  WritingMainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingMainView: View {
    @State private var showFreeView = false
    @State private var showQuestionView = false
    @State private var showEmotionView = false
    @State private var showInspirationView = false
    @State private var showCards = true
    
    @State var recordType = Record.free
    @State private var oneSentence: String
    
    init() {
        let key = UserDefaultKey.oneSentence.string
        if let oneSentence = UserDefaults.standard.object(forKey: key) as? String {
            self.oneSentence = oneSentence
        } else {
            oneSentence = ""
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Image("Logo")
                                .padding(.leading, 10)
                            Spacer()
                            if showCards {
                                SoundView()
                            }
                        }
                        .foregroundColor(Color.gray23)
                        .font(.bigTitle)
                        .padding(.bottom, 30)
                        .padding(.top, 20)
                        OneSentence()
                    }
                    .padding(.horizontal, 20)
                    if showCards {
                        WritingBoxes()
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
    private func OneSentence() -> some View {
        TextField("나의 한 마디", text: $oneSentence)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(25)
            .background(Color.grayF5)
            .font(.bodyRegular)
            .foregroundColor(Color.gray23)
            .cornerRadius(10)
            .padding(.bottom, 20)
            .onChange(of: oneSentence) { newValue in
                let key = UserDefaultKey.oneSentence.string
                UserDefaults.standard.set(newValue, forKey: key)
            }
            .onTapGesture {
                showCards = false
            }
            .onSubmit {
                showCards = true
            }
            .submitLabel(.done)
    }
    @ViewBuilder
    private func WritingBoxes() -> some View {
        ScrollView(.horizontal, showsIndicators : false){
            HStack{
                let records = Record.allCases
                let width = UIScreen.main.bounds.width/1.5
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
                                .foregroundColor(.gray23)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
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
                    .shadow(color: .gray.opacity(0.5), radius: 7, x: 10, y:10)
                }
                .padding(.leading, 60)
                .padding(.trailing, 150)
            }
        }
    }
}

struct WritingMainView_Previews: PreviewProvider {
    static var previews: some View {
        WritingMainView()
            .environmentObject(SoundViewModel())
    }
}
