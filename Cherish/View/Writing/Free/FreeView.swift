//
//  FreeView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct FreeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("제목", text: $title)
                    .font(.miniTitle)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                    .padding(.horizontal, 20)
                WritingView()
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .navigationBarTitle(Record.free.writingMainText(), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    // TODO: make isMusicOn as Environment object
                    MusicView(isMusicOn: .constant(false))
                    Spacer()
                    Button {
                        // TODO: 저장 로직 추가
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .textInputAutocapitalization(.never)
        }
    }
}

struct FreeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeView()
    }
}
