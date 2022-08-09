//
//  WritingMainView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct WritingMainView: View {
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16, alignment: nil),
        GridItem(.flexible(), spacing: 16, alignment: nil)
    ]
    @State private var isMusicOn = true
    @State private var showOneSentence = false
    @State private var oneSentence = "그냥 꾸준히 뭔가를 해보자"
    
    @State var ispresent = false
    @State var recordType = Record.free
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("PaperBackground")
                    .resizable()
                    .ignoresSafeArea(.all, edges: [.bottom,.top])
                    .opacity(0.4)
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Title()
                        OneSentence()
                    }
                    .padding(.horizontal, 20)
                    WritingBoxes()
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .automatic)
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $ispresent) {
                switch recordType {
                    case .free:
                        VStack(spacing: 0) {
                            FreeView()
                        }
                    case .question:
                        VStack(spacing: 0) {
                            SelectQuestionView(isModalShow: $ispresent)
                        }
                    case .emotion:
                        VStack(spacing: 0) {
                            SelectingEmotionView(isModalShow: $ispresent)
                        }
                    case .inspiration:
                        VStack(spacing: 0) {
                            SelectingInspirationView(isModalShow: $ispresent)
                        }
                }
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .accentColor(Color.defaultText)
        .foregroundColor(Color.defaultText)
        .ignoresSafeArea(.keyboard)
    }
}

extension WritingMainView {
    @ViewBuilder
    private func Title() -> some View {
        HStack(spacing: 0) {
            Text("ㅇㅏㄲㅣㄷㅏ")
            Spacer()
            MusicView(isMusicOn: $isMusicOn)
        }
        .font(.bigTitle)
        .padding(.bottom, 30)
        .padding(.top, 20)
    }
    @ViewBuilder
    private func OneSentence() -> some View {
        Text(oneSentence)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(25)
            .background(.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
            .onTapGesture {
                showOneSentence = true
            }
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
                                    Text("  \(Int(index)). \(record.writingMainText)  ")
                                        .font(.bigTitle)
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
                        .onTapGesture {
                            recordType = record
                            ispresent = true
                        }
                    }
                    .frame(width: width * 1.2)
                    .shadow(color: .gray.opacity(0.4), radius: 4, x: 15, y:15)
                }
            }
            .padding(.leading, 60)
            .padding(.trailing, 150)
        }
    }
}

struct WritingMainView_Previews: PreviewProvider {
    static var previews: some View {
        WritingMainView()
    }
}
