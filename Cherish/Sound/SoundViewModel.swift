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
            if isMusicOn {
                UserDefaults.standard.set(true, forKey: "isMusicOn")
            } else {
                UserDefaults.standard.set(false, forKey: "isMusicOn")
            }
        }
    }
    
    init() {
        if let isMusicOn = UserDefaults.standard.object(forKey: "isMusicOn") as? Bool {
            self.isMusicOn = isMusicOn
        } else {
            UserDefaults.standard.set(true, forKey: "isMusicOn")
            self.isMusicOn = true
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
    }
}
