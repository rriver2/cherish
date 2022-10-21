//
//  SelectSoundView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/06.
//

import SwiftUI

struct SelectSoundView: View {
    @EnvironmentObject var soundViewModel: SoundViewModel
    @State var selectedSound: SoundCategory?
    @Environment(\.dismiss) private var dismiss
    @Binding var isShowTabbar: Bool
    @State var isCheckButton = false
    
    var body: some View {
        VStack(spacing: 0) {
            title()
                .padding(.bottom, 70)
            VStack(spacing: 40) {
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
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedSound = sound
                        soundViewModel.pressTempSound(sound: sound)
                    }
                }
            }
            Spacer()
        }
        .paddingHorizontal()
        .onAppear {
            selectedSound = soundViewModel.soundCategory
            isShowTabbar = false
        }
        .onDisappear {
            isShowTabbar = true
            if !isCheckButton {
                if let selectedSound = selectedSound {
                soundViewModel.cancelSoundFullscreen(sound: selectedSound)
                }
            }
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
                    isCheckButton = true
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
                    isCheckButton = true
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
