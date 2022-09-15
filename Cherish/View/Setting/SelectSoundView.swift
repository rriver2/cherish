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
    @Binding var isShowTabbar: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            title()
                .padding(.bottom, 70)
            ForEach(SoundCategory.allCases, id: \.self) { sound in
                let soundName = sound.displayName
                HStack(alignment: .center, spacing: 0) {
                    Text(soundName)
                        .font(sound == selectedSound ?.bodySemibold : .bodyRegular)
                        .foregroundColor(.gray23)
                    Spacer()
                    if sound == selectedSound {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16))
                            .foregroundColor(.gray23)
                    }
                    #warning("background -> white 없애기")
                }
                .padding(.bottom, 27)
                .background(.white)
                .onTapGesture {
                    selectedSound = sound
                    soundViewModel.pressTempSound(sound: sound)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 27)
        .onAppear {
            selectedSound = soundViewModel.soundCategory
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
        }
        .navigationBarBackButtonHidden(true)
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
                    if let selectedSound = selectedSound {
                    soundViewModel.cancelSoundFullscreen(sound: selectedSound)
                    }
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
                    if let selectedSound = selectedSound {
                        soundViewModel.soundCategory = selectedSound
                        soundViewModel.confirmSoundFullscreen(sound: selectedSound)
                    }
                    dismiss()
                }
        }
        .frame(height: 20)
        .foregroundColor(Color.gray23)
        .font(.timeLineTitle)
        .padding(.top, 26)
    }
}

struct SelectSoundView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSoundView(isShowTabbar: .constant(false))
            .environmentObject(SoundViewModel())
    }
}
