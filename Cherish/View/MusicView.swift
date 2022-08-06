//
//  MusicView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct MusicView: View {
    @Binding var isMusicOn: Bool
    var body: some View {
        Image(systemName: isMusicOn ? "speaker.wave.2.fill" : "speaker.wave.2")
            .onTapGesture {
                isMusicOn.toggle()
                // TODO: on off the sound
            }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView(isMusicOn: .constant(false))
    }
}
