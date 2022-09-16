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
    @Environment(\.colorScheme) private var colorScheme
    @State var audio : AVAudioPlayer?
    
    var body: some View {
        let colorMode = colorScheme == .light ? "LightMode" : "DarkMode"
            Image(soundViewModel.isSoundOn ? "SoundOn\(colorMode)" : "SoundOff\(colorMode)")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 22)
                .onTapGesture {
                    soundViewModel.pressSound()
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
