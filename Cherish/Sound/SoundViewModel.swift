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
            } else {
                UserDefaults.standard.set(false, forKey: key)
            }
        }
    }
    
    init() {
        let key = UserDefaultKey.isMusicOn.string
        if let isMusicOn = UserDefaults.standard.object(forKey: key) as? Bool {
            self.isMusicOn = isMusicOn
        } else {
            UserDefaults.standard.set(true, forKey: key)
            self.isMusicOn = true
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
    }
}
