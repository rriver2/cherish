//
//  WritingMainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingMainView: View {
    
    @State var ispresent = false
    @State var recordType = Record.free
    
    @State private var showFreeView = false
    @State private var showQuestionView = false
    @State private var showEmotionView = false
    @State private var showInspirationView = false
    @State private var showCards = true
    
    @State private var oneSentence: String
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil)
    ]
    
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
                Image("PaperBackground")
                    .resizable()
                    .ignoresSafeArea(.all, edges: [.bottom,.top])
                    .opacity(0.4)
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        TitleView(title: "ㅇㅏㄲㅣㄷㅏ")
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
            //            .fullScreenCover(isPresented: $ispresent) {
            //                switch recordType {
            //                    case .free:
            //                        VStack(spacing: 0) {
            //                            FreeView()
            //                        }
            //                    case .question:
            //                        VStack(spacing: 0) {
            //                            SelectQuestionView(isModalShow: $ispresent)
            //                        }
            //                    case .emotion:
            //                        VStack(spacing: 0) {
            //                            SelectingEmotionView(isModalShow: $ispresent)
            //                        }
            //                    case .inspiration:
            //                        VStack(spacing: 0) {
            //                            SelectingInspirationView(isModalShow: $ispresent)
            //                        }
            //                }
            //
            //            }
            .fullScreenCover(isPresented: $showFreeView) {
                FreeView()
            }
            .fullScreenCover(isPresented: $showQuestionView) {
                SelectQuestionView(isModalShow: $showQuestionView)
            }
            .fullScreenCover(isPresented: $showEmotionView) {
                SelectingEmotionView(isModalShow: $showEmotionView)
            }
            //            .fullScreenCover(isPresented: $showInspirationView) {
            //                SelectingInspirationView(isModalShow: $showInspirationView)
            //            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .accentColor(Color.defaultText)
        .foregroundColor(Color.defaultText)
        .ignoresSafeArea(.keyboard)
    }
}

extension WritingMainView {
    @ViewBuilder
    private func OneSentence() -> some View {
        TextField("나의 한마디", text: $oneSentence)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(25)
            .background(.white)
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
                        ZStack  {
                            Image(record.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: width*1.5)
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 0) {
                                    Text("\(record.writingMainText)")
                                        .font(.bigTitle)
                                        .padding(.horizontal, 10)
                                        .background(.white.opacity(0.5))
                                    Spacer()
                                }
                                .padding(.top, 20)
                                Spacer()
                            }
                            .padding(.leading, 20)
                        }
                        .frame(width: width, height: width*1.5)
                        .cornerRadius(10)
                        .rotation3DEffect(.degrees(Double(geomitry.frame(in: .global).minX / -8)), axis: (x: 0.0, y: 0.0, z: 2.0))
                        .offset(x: 0, y: 50)
                        //                        .onTapGesture {
                        //                            recordType = record
                        //                            ispresent = true
                        //                        }
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
                    .frame(width: width/1.5)
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 15, y:15)
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
