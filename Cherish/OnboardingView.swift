//
//  OnboardingView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isShowOnboarding: Bool
    @State var onBoardingNumber: Int = 0
    @EnvironmentObject var soundViewModel: SoundViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 7) {
                Text("Skip")
                    .foregroundColor(.clear)
                Spacer()
                Circles()
                Spacer()
                SkipButton()
            }
            .padding(.top, 37)
            .padding(.bottom, 37)
            
            VStack(alignment: .center, spacing: 0) {
                let colorSchemeString = DarkModeViewModel.colorSchemeString(mode: colorScheme)
                let imageName = "Onboarding" + colorSchemeString + String(onBoardingNumber+1)
                ZStack(alignment: .bottom) {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width)
                    NextButton()
                }
            }
        }
        .padding(.horizontal, 27)
    }
    
    func endOnboarding() {
        let key = UserDefaultKey.isShowOnboarding.string
        UserDefaults.standard.set(false, forKey: key)
        isShowOnboarding = false
    }
}

extension OnboardingView {
    @ViewBuilder
    func SkipButton() -> some View {
        if onBoardingNumber != 5 {
        Button {
            endOnboarding()
        } label: {
            Text("Skip")
                .foregroundColor(.grayA7)
        }
        } else {
            Text("Skip")
                .foregroundColor(.clear)
        }
    }
    @ViewBuilder
    func Circles() -> some View {
        let array = Array(0..<6)
        ForEach(array, id: \.self) { index in
            Circle()
                .foregroundColor(index == onBoardingNumber ? Color.gray23 : Color(hex: "D2D2D2"))
                .frame(width: 8, height: 8)
        }
    }
    @ViewBuilder
    func NextButton() -> some View {
        if onBoardingNumber == 5 {
            VStack(spacing: 0) {
                Button {
                    endOnboarding()
                    soundViewModel.isMusicOn = true
                } label: {
                    Text("음악과 함께 시작하기")
                        .font(.bodySemibold)
                        .foregroundColor(Color(hex: "F5F5F5"))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "232323"))
                        .cornerRadius(10)
                        .padding(.horizontal, 27)
                        .padding(.bottom, 13)
                }
                
                
                Button {
                    endOnboarding()
                    soundViewModel.isMusicOn = false
                } label: {
                    Text("음악 없이 시작하기")
                        .font(.miniSemibold)
                        .foregroundColor(Color(hex: "232323"))
                        .padding(.horizontal, 27)
                        .padding(.bottom, 30)
                }
            }
        } else {
            Button {
                onBoardingNumber += 1
            } label: {
                Text("다음으로")
                    .font(.bodySemibold)
                    .foregroundColor(Color(hex: "F5F5F5"))
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "232323"))
                    .cornerRadius(10)
                    .padding(.horizontal, 27)
                    .padding(.bottom, 58)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowOnboarding: .constant(false))
    }
}
