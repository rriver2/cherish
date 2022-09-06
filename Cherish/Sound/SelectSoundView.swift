//
//  SelectSoundView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/06.
//

import SwiftUI

struct SelectSoundView: View {
    @EnvironmentObject var soundViewModel: SoundViewModel
    #warning("environment init되고 값을 넣고 싶은데.. 오또케 하냐 !!")
    @State var selectedSound: SoundCategory?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            title()
            ForEach(SoundCategory.allCases, id: \.self) { sound in
                let soundName = sound.displayName
                HStack(alignment: .center, spacing: 0) {
                    Text(soundName)
                        .font(sound == selectedSound ?.bodySemibold : .bodyRegular)
                        .foregroundColor(.gray23)
                    Spacer()
                    if sound == selectedSound {
                        Image("check")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 13, height: 9)
                            .foregroundColor(.gray23)
                            .font(.bodyRegular)
                    }
                    #warning("background -> white 없애기")
                }
                .padding(.bottom, 25)
                .background(.white)
                .onTapGesture {
                    selectedSound = sound
                }
            }
            Spacer()
        }
        .padding(.horizontal, 27)
        .onAppear {
            selectedSound = soundViewModel.soundCategory
        }
    }
}

extension SelectSoundView {
    @ViewBuilder
    private func title() -> some View {
        HStack(spacing: 0) {
            Text("취소")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.gray23)
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Text("소리 변경")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color.gray23)
            Spacer()
            Text("완료")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.gray23)
                .onTapGesture {
                    soundViewModel.soundCategory = selectedSound ?? .brightNightCity
                    dismiss()
                }
        }
        .frame(height: 20)
        .padding(.bottom, 49)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
    }
}

struct SelectSoundView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSoundView()
            .environmentObject(SoundViewModel())
    }
}
