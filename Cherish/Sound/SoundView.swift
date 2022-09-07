//
//  SoundView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI
import AVFoundation

struct SoundView: View {
    @EnvironmentObject var soundViewModel: SoundViewModel
    @State var audio : AVAudioPlayer?
    @State var isShowChangeMusicFullScreen = false
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.3)
               .onEnded { _ in
                       isShowChangeMusicFullScreen = true
               }
       }
    
    var body: some View {
            Image(soundViewModel.isSoundOn ? "SoundOn" : "SoundOff")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 22)
                .onTapGesture {
                    soundViewModel.pressSound()
                }
                .gesture(longPress)
                .fullScreenCover(isPresented: $isShowChangeMusicFullScreen) {
                    SelectSoundView()
                }
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
            .preferredColorScheme(.dark)
            .environmentObject(SoundViewModel())
    }
}
