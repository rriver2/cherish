//
//  SoundViewModel.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/10.
//

import SwiftUI
import AVFoundation

class SoundViewModel: ObservableObject {
    @Published var isSoundOn: Bool {
        didSet {
            let key = UserDefaultKey.isSoundOn.rawValue
            UserDefaults.standard.set(isSoundOn, forKey: key)
        }
    }
    
    @Published var audio : AVAudioPlayer?
    
    @Published var soundCategory: SoundCategory
    
    init() {
        var key = UserDefaultKey.isSoundOn.rawValue
        if let isSoundOn = UserDefaults.standard.object(forKey: key) as? Bool {
            self.isSoundOn = isSoundOn
        } else {
            UserDefaults.standard.set(false, forKey: key)
            self.isSoundOn = false
        }
        
        key = UserDefaultKey.soundCategory.rawValue
        if let rawValue = UserDefaults.standard.object(forKey: key) as? String,
           let soundCategory = SoundCategory(rawValue: rawValue){
            self.soundCategory = soundCategory
        } else {
            UserDefaults.standard.set(SoundCategory.brightNightCity.rawValue, forKey: key)
            self.soundCategory = .brightNightCity
        }
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("Failed to set audio session category.")
        }
        
        let song = NSDataAsset (name: soundCategory.fileName)
        if let data = song?.data {
            self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
            self.audio?.numberOfLoops = -1
            playSound()
        }
    }
    
    func pressSound(isSoundOn: Bool? = nil) {
        if let isSoundOn = isSoundOn {
            self.isSoundOn = isSoundOn
        } else {
            self.isSoundOn.toggle()
        }
        
        playSound()
    }
    
    func playSound() {
        if self.isSoundOn {
            self.audio?.prepareToPlay()
            self.audio?.play()
        } else {
            self.audio?.pause()
        }
    }
    
    func pressTempSound(sound: SoundCategory) {
        let song = NSDataAsset (name: sound.fileName)
        if let data = song?.data {
            self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
            self.audio?.numberOfLoops = -1
            self.audio?.prepareToPlay()
            self.audio?.play()
        }
    }
    
    func cancelSoundFullscreen(sound: SoundCategory) {
        if isSoundOn {
            if soundCategory == sound {
                self.isSoundOn = true
            } else {
                let song = NSDataAsset (name: soundCategory.fileName)
                if let data = song?.data {
                    self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
                    self.audio?.numberOfLoops = -1
                    self.isSoundOn = true
                    self.audio?.prepareToPlay()
                    self.audio?.play()
                }
            }
        } else {
            let song = NSDataAsset (name: soundCategory.fileName)
            if let data = song?.data {
                self.audio = try? AVAudioPlayer(data: data, fileTypeHint: "mp3")
                self.audio?.numberOfLoops = -1
                self.isSoundOn = false
            }
        }
    }
    
    func confirmSoundFullscreen(sound: SoundCategory) {
        self.soundCategory = sound
        let key = UserDefaultKey.soundCategory.rawValue
        UserDefaults.standard.set(sound.rawValue, forKey: key)
        self.isSoundOn = true
    }
}
