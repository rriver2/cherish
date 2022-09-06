//
//  SoundViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/10.
//

import SwiftUI
import AVFoundation

class SoundViewModel: ObservableObject {
    @Published var isMusicOn: Bool {
        didSet {
            let key = UserDefaultKey.isMusicOn.string
            if isMusicOn {
                UserDefaults.standard.set(true, forKey: key)
                playSound()
            } else {
                UserDefaults.standard.set(false, forKey: key)
                playSound()
            }
        }
    }
    
    @Published var audio : AVAudioPlayer?
    
    @Published var soundCategory: SoundCategory = .brightNightCity
    
    init() {
        let key = UserDefaultKey.isMusicOn.string
        if let isMusicOn = UserDefaults.standard.object(forKey: key) as? Bool {
            self.isMusicOn = isMusicOn
        } else {
            UserDefaults.standard.set(false, forKey: key)
            self.isMusicOn = false
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("Failed to set audio session category.")
        }
        
        let song = NSDataAsset (name: "AfterTheRain")
        if let data = song?.data {
            self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
            self.audio?.numberOfLoops = -1
            playSound()
        }
    }
    
    func playSound() {
        if self.isMusicOn {
            self.audio?.prepareToPlay()
            self.audio?.play()
        } else {
            self.audio?.pause()
        }
    }
}
