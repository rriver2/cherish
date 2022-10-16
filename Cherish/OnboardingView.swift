//
//  OnboardingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowOnboarding: Bool
    @State var onBoardingNumber: Int
    @EnvironmentObject var soundViewModel: SoundViewModel
    @Environment(\.colorScheme) private var colorScheme
    let imageName: String
    let imageCount: Int
    
    init(isShowOnboarding: Binding<Bool>, onBoardingNumber: Int = 0, onBoardingCategory: OnBoardingCategory) {
        self._isShowOnboarding = isShowOnboarding
        self._onBoardingNumber = State(initialValue: onBoardingNumber)
        self.imageName = onBoardingCategory.rawValue
        self.imageCount = onBoardingCategory.imageCount
    }
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            TabView(selection: $onBoardingNumber) {
                let array = Array(0..<imageCount)
                ForEach(array, id: \.self) { index in
                    VStack(alignment: .center, spacing: 0) {
                        let colorSchemeString = DarkModeViewModel.colorSchemeString(mode: colorScheme)
                        let imageName = imageName + colorSchemeString + String(index+1)
                        ZStack(alignment: .bottom) {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                        }
                    }
                    .padding(.top, 97)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("NEW")
                        .foregroundColor(imageName == OnBoardingCategory.update.rawValue ? .gray23 : .clear)
                    Spacer()
                    Circles()
                    Spacer()
                    SkipButton()
                }
                .padding(.horizontal, 39)
                .padding(.top, 25)
                Spacer()
                NextButton()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    func endOnboarding() {
        var key = ""
        if imageName == OnBoardingCategory.firstTime.rawValue {
            key = UserDefaultKey.isShowOnboarding.rawValue
            UserDefaults.standard.set(false, forKey: key)
        } else if imageName == OnBoardingCategory.update.rawValue {
            key = UserDefaultKey.versionRecord.rawValue
            if let nowVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                UserDefaults.standard.set(nowVersion, forKey: key)
            }
        }
        isShowOnboarding = false
    }
}

extension OnboardingView {
    @ViewBuilder
    func SkipButton() -> some View {
        if onBoardingNumber != imageCount-1 {
            Button {
                endOnboarding()
            } label: {
                Text("Skip")
                    .foregroundColor(.grayEE)
            }
        } else {
            Text("Skip")
                .foregroundColor(.clear)
        }
    }
    @ViewBuilder
    func Circles() -> some View {
        let array = Array(0..<imageCount)
        ForEach(array, id: \.self) { index in
            Circle()
                .foregroundColor(index == onBoardingNumber ? Color.gray23 : Color.grayE8)
                .frame(width: 8, height: 8)
                .padding(.horizontal, 3)
        }
    }
    @ViewBuilder
    func NextButton() -> some View {
        if onBoardingNumber == imageCount-1 && imageName == OnBoardingCategory.firstTime.rawValue {
            VStack(spacing: 0) {
                Button {
                    endOnboarding()
                    soundViewModel.pressSound(isSoundOn: true)
                } label: {
                    Text("음악과 함께 시작하기")
                        .font(.bodySemibold)
                        .foregroundColor(Color(hex: "F5F5F5"))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "232323"))
                        .cornerRadius(10)
                        .paddingHorizontal()
                        .padding(.bottom, 13)
                }
                
                Button {
                    endOnboarding()
                    soundViewModel.pressSound(isSoundOn: false)
                } label: {
                    Text("음악 없이 시작하기")
                        .font(.miniSemibold)
                        .foregroundColor(Color(hex: "232323"))
                        .paddingHorizontal()
                        .padding(.bottom, 30)
                }
            }
        } else if onBoardingNumber == imageCount-1 && imageName == OnBoardingCategory.update.rawValue {
            VStack(spacing: 0) {
                Button {
                    endOnboarding()
                } label: {
                    Text("확인")
                        .font(.bodySemibold)
                        .foregroundColor(Color(hex: "F5F5F5"))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "232323"))
                        .cornerRadius(10)
                        .paddingHorizontal()
                        .padding(.bottom, 13)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowOnboarding: .constant(false), onBoardingCategory: OnBoardingCategory.update)
    }
}
