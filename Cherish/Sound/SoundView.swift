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
    
    var body: some View {
        Button {
            soundViewModel.isMusicOn.toggle()
        } label: {
            Image(systemName: soundViewModel.isMusicOn ? "speaker.wave.2.fill" : "speaker.wave.2")
                .foregroundColor(Color.gray23)
        }
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
            .environmentObject(SoundViewModel())
    }
}
