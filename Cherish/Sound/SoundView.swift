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
        }
        .onAppear {
            let song = NSDataAsset (name: "AfterTheRain")
            if let data = song?.data {
                self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
                self.audio?.numberOfLoops = -1
                playSound()
            }
        }
        .onChange(of: soundViewModel.isMusicOn, perform: { newValue in
            playSound()
        })
    }
    
    private func playSound() {
        if soundViewModel.isMusicOn {
            self.audio?.prepareToPlay()
            self.audio?.play()
        } else {
            self.audio?.pause()
        }
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        SoundView()
            .environmentObject(SoundViewModel())
    }
}
